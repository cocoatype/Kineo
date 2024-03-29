//  Created by Geoff Pado on 12/24/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Combine
import DocumentNavigationPhone
import EditingStatePhone
import StylePhone
import UIKit

class FilmStripView: UIControl, UICollectionViewDelegate, UICollectionViewDragDelegate, UICollectionViewDropDelegate, UIGestureRecognizerDelegate {
    init(statePublisher: EditingStatePublisher) {
        self.dataSource = FilmStripDataSource(statePublisher: statePublisher)
        super.init(frame: .zero)

        accessibilityHint = NSLocalizedString("FilmStripView.accessibilityHint", comment: "Accessibility hint for the film strip")
        accessibilityLabel = NSLocalizedString("FilmStripView.accessibilityLabel", comment: "Accessibility label for the film strip")
        accessibilityTraits = [.adjustable, .button]
        accessibilityValue = accessibilityValueForCurrentIndex()
        backgroundColor = Asset.filmStripBackground.color
        clipsToBounds = false
        isAccessibilityElement = true
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false

        collectionView.dataSource = self.dataSource
        collectionView.delegate = self
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self

        addGestureRecognizer(gestureRecognizer)

        addSubview(collectionView)
        addSubview(indicator)
        addSubview(foregroundView)

        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor),
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
            foregroundView.widthAnchor.constraint(equalTo: widthAnchor),
            foregroundView.heightAnchor.constraint(equalTo: heightAnchor),
            foregroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            foregroundView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        installIndicatorConstraints()

        statePublisher.sink { [weak self] _ in
            self?.reloadData()
        }.store(in: &cancellables)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let indicatorSize = indicator.intrinsicContentSize
        var indicatorFrame = CGRect(origin: .zero, size: indicatorSize)
        if traitCollection.horizontalSizeClass == .compact {
            indicatorFrame.origin.y = bounds.minY - (indicatorSize.height / 2)
            indicatorFrame.origin.x = bounds.minX + 8
        } else {
            indicatorFrame.origin.x = bounds.maxX + (indicatorSize.width / 2)
            indicatorFrame.origin.y = bounds.minY + 8
        }

        indicator.frame = indicatorFrame
    }

    func reloadData() {
        collectionView.reloadData()
        Task { @MainActor in
            collectionView.scrollToItem(at: IndexPath(item: dataSource.currentPageIndex, section: 0), at: .top, animated: true)
        }
        accessibilityValue = accessibilityValueForCurrentIndex()
    }

    private func installIndicatorConstraints() {
        if traitCollection.horizontalSizeClass == .compact {
            NSLayoutConstraint.activate([
                indicator.centerYAnchor.constraint(equalTo: topAnchor),
                indicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
            ])
        } else {
            NSLayoutConstraint.activate([
                indicator.centerXAnchor.constraint(equalTo: trailingAnchor),
                indicator.topAnchor.constraint(equalTo: topAnchor, constant: 8)
            ])
        }
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if dataSource.isNewPage(indexPath) {
            sendAction(#selector(EditingDrawViewController.addNewPage), to: nil, for: nil)
        } else {
            sendAction(#selector(EditingDrawViewController.navigateToPage(_:for:)), to: nil, for: PageNavigationEvent(pageIndex: indexPath.item))
        }

        collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        accessibilityValue = accessibilityValueForCurrentIndex()
        guard scrollView.isScrollUserInitiated, let layout = collectionView.collectionViewLayout as? FilmStripCollectionViewLayout else { return }
        let pageIndex = layout.indexOfItem(atContentOffset: scrollView.contentOffset)
        sendAction(#selector(EditingDrawViewController.navigateToPage(_:for:)), to: nil, for: PageNavigationEvent(pageIndex: pageIndex))
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        sendAction(#selector(EditingDrawViewController.startScrolling), to: nil, for: nil)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        sendAction(#selector(EditingDrawViewController.stopScrolling), to: nil, for: nil)
    }

    // MARK: Drag Delegate

    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard indexPath.item < dataSource.latestState.pageCount else { return [] }

        let page = dataSource.page(at: indexPath)
        return [FilmStripPageDragItem(page: page)]
    }

    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return nil }
        let parameters = UIDragPreviewParameters()
        parameters.visiblePath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: 8)
        return parameters
    }

    // MARK: Drop Delegate

    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else { return }
        coordinator.items.forEach { item in
            guard let sourceIndexPath = item.sourceIndexPath else { return }
            sendAction(#selector(EditingDrawViewController.movePage(_:for:)), to: nil, for: FilmStripMoveEvent(source: sourceIndexPath, destination: destinationIndexPath))
            collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
    }

    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }

    // MARK: Accessibility

    override func accessibilityIncrement() {
        guard let layout = collectionView.collectionViewLayout as? FilmStripCollectionViewLayout else { return }
        let currentIndex = layout.indexOfItem(atContentOffset: collectionView.contentOffset)
        let maxIndex = dataSource.collectionView(collectionView, numberOfItemsInSection: 0) - 1
        guard currentIndex + 1 < maxIndex else { return }
        collectionView(collectionView, didSelectItemAt: IndexPath(item: currentIndex + 1, section: 0))
    }

    override func accessibilityDecrement() {
        guard let layout = collectionView.collectionViewLayout as? FilmStripCollectionViewLayout else { return }
        let currentIndex = layout.indexOfItem(atContentOffset: collectionView.contentOffset)
        guard currentIndex - 1 >= 0 else { return }
        collectionView(collectionView, didSelectItemAt: IndexPath(item: currentIndex - 1, section: 0))
    }

    override func accessibilityActivate() -> Bool {
        let maxIndex = dataSource.collectionView(collectionView, numberOfItemsInSection: 0) - 1
        collectionView(collectionView, didSelectItemAt: IndexPath(item: maxIndex, section: 0))
        return true
    }

    private func accessibilityValueForCurrentIndex() -> String {
        guard let layout = collectionView.collectionViewLayout as? FilmStripCollectionViewLayout else { return "" }
        let currentPage = layout.indexOfItem(atContentOffset: collectionView.contentOffset) + 1
        let itemsCount = dataSource.collectionView(collectionView, numberOfItemsInSection: 0) - 1
        return String(format: Self.accessibilityValueFormat, currentPage, itemsCount)
    }

    // MARK: Gesture Recognizer

    private lazy var gestureRecognizer: UILongPressGestureRecognizer = {
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(userDidTouchFilmStrip(_:)))
        gestureRecognizer.delegate = self
        gestureRecognizer.minimumPressDuration = 0.1
        return gestureRecognizer
    }()

    @objc private func userDidTouchFilmStrip(_ recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began:
            sendAction(#selector(EditingDrawViewController.startScrolling), to: nil, for: nil)
        case .ended, .failed:
            guard collectionView.isDecelerating == false else { break }
            sendAction(#selector(EditingDrawViewController.stopScrolling), to: nil, for: nil)
        default: break
        }
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool { true }

    // MARK: Enabled

    override var isEnabled: Bool {
        didSet {
            isUserInteractionEnabled = isEnabled
            UIView.animate(withDuration: 0.3) {
                self.alpha = self.isEnabled ? 1.0 : 0.2
            }
        }
    }

    // MARK: Boilerplate

    private static let accessibilityValueFormat = NSLocalizedString("FilmStripView.accessibilityValueFormat", comment: "Format string for the accessibility value of the film strip")

    private var cancellables = Set<AnyCancellable>()
    private let collectionView = FilmStripCollectionView()
    private let dataSource: FilmStripDataSource
    private let foregroundView = FilmStripForegroundView()
    private let indicator = FilmStripIndicator()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
