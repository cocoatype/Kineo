//  Created by Geoff Pado on 5/20/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import PhotosUI
import UIKit

class PhotoPicker: NSObject, PHPickerViewControllerDelegate {
    @MainActor
    func present(from viewController: UIViewController, sourceView: UIView?) async throws -> Data? {
        let picker = PHPickerViewController(configuration: PHPickerConfiguration())
        picker.delegate = self
        picker.modalPresentationStyle = .popover

        if let sourceView = sourceView {
            picker.popoverPresentationController?.sourceView = sourceView
            picker.popoverPresentationController?.sourceRect = sourceView.bounds
        }

        return try await withCheckedThrowingContinuation { continuation in
            pickerContinuation = continuation
            viewController.present(picker, animated: true)
        }
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard let result = results.first,
              let typeIdentifier = result.itemProvider.registeredTypeIdentifiers.first
        else { return pickerContinuation?.resume(returning: nil) ?? () }

        result.itemProvider.loadDataRepresentation(forTypeIdentifier: typeIdentifier) { [weak self] data, error in
            if let error = error {
                self?.pickerContinuation?.resume(throwing: error)
            } else {
                self?.pickerContinuation?.resume(returning: data)
            }
        }
        picker.dismiss(animated: true)
    }

    private var pickerContinuation: CheckedContinuation<Data?, Error>?
}
