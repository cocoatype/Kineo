//  Created by Geoff Pado on 1/24/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import StylePhone
typealias StyleAsset = StylePhone.Asset
#elseif os(visionOS)
import StyleVision
typealias StyleAsset = StyleVision.Asset
#endif
