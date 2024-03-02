//  Created by Geoff Pado on 2/26/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import AVKit
import SwiftUI

struct DebugVideoView: UIViewControllerRepresentable {
    private let videoURL: URL
    init(videoURL: URL) {
        self.videoURL = videoURL
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = AVPlayerViewController()
        viewController.player = AVPlayer(url: videoURL)
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
