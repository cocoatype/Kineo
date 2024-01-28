//  Created by Geoff Pado on 1/28/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import StylePhone
#elseif os(visionOS)
import StyleVision
#endif

#if os(iOS)
typealias StyleAsset = StylePhone.Asset
#elseif os(visionOS)
typealias StyleAsset = StyleVision.Asset
#endif
