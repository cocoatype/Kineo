// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum KineoAsset {
  public static let appAccent1 = KineoColors(name: "App Accent 1")
  public static let appAccent = KineoColors(name: "App Accent")
  public static let background = KineoColors(name: "Background")
  public static let canvasBackground = KineoColors(name: "Canvas Background")
  public static let canvasBorder = KineoColors(name: "Canvas Border")
  public static let canvasShadowDark = KineoColors(name: "Canvas Shadow Dark")
  public static let canvasShadowLight = KineoColors(name: "Canvas Shadow Light")
  public static let cellTitle = KineoColors(name: "Cell Title")
  public static let exportAccent = KineoColors(name: "Export Accent")
  public static let filmStripBackground = KineoColors(name: "Film Strip Background")
  public static let filmStripBorder = KineoColors(name: "Film Strip Border")
  public static let filmStripIndicator = KineoColors(name: "Film Strip Indicator")
  public static let filmStripShadowDark = KineoColors(name: "Film Strip Shadow Dark")
  public static let filmStripShadowLight = KineoColors(name: "Film Strip Shadow Light")
  public static let newDocumentCellTint = KineoColors(name: "New Document Cell Tint")
  public static let purchaseMarketingBackground = KineoColors(name: "Purchase Marketing Background")
  public static let purchaseMarketingButtonPressedGradientDark = KineoColors(name: "Purchase Marketing Button Pressed Gradient Dark")
  public static let purchaseMarketingButtonPressedGradientLight = KineoColors(name: "Purchase Marketing Button Pressed Gradient Light")
  public static let purchaseMarketingButtonShadowDark = KineoColors(name: "Purchase Marketing Button Shadow Dark")
  public static let purchaseMarketingButtonShadowLight = KineoColors(name: "Purchase Marketing Button Shadow Light")
  public static let purchaseMarketingCellBackground = KineoColors(name: "Purchase Marketing Cell Background")
  public static let purchaseMarketingCellText = KineoColors(name: "Purchase Marketing Cell Text")
  public static let purchaseMarketingTopBarBackground = KineoColors(name: "Purchase Marketing Top Bar Background")
  public static let purchaseMarketingTopBarHeadline = KineoColors(name: "Purchase Marketing Top Bar Headline")
  public static let purchaseMarketingTopBarSubheadline = KineoColors(name: "Purchase Marketing Top Bar Subheadline")
  public static let settingsCellBackground = KineoColors(name: "Settings Cell Background")
  public static let settingsRowTint = KineoColors(name: "Settings Row Tint")
  public static let shadow = KineoColors(name: "Shadow")
  public static let sidebarBackground = KineoColors(name: "Sidebar Background")
  public static let sidebarBorder = KineoColors(name: "Sidebar Border")
  public static let sidebarButtonBackgroundSelected = KineoColors(name: "Sidebar Button Background (Selected)")
  public static let sidebarButtonBackground = KineoColors(name: "Sidebar Button Background")
  public static let sidebarButtonBorder = KineoColors(name: "Sidebar Button Border")
  public static let sidebarButtonHighlight = KineoColors(name: "Sidebar Button Highlight")
  public static let sidebarButtonPressedGradientDark = KineoColors(name: "Sidebar Button Pressed Gradient Dark")
  public static let sidebarButtonPressedGradientLight = KineoColors(name: "Sidebar Button Pressed Gradient Light")
  public static let sidebarButtonShadowDark = KineoColors(name: "Sidebar Button Shadow Dark")
  public static let sidebarButtonShadowLight = KineoColors(name: "Sidebar Button Shadow Light")
  public static let sidebarButtonTintSelected = KineoColors(name: "Sidebar Button Tint (Selected)")
  public static let sidebarButtonTint = KineoColors(name: "Sidebar Button Tint")
  public static let tutorialIntroAccent = KineoColors(name: "Tutorial Intro Accent")
  public static let tutorialIntroDismissButtonTitle = KineoColors(name: "Tutorial Intro Dismiss Button Title")
  public static let tutorialIntroStartButtonTitle = KineoColors(name: "Tutorial Intro Start Button Title")
  public static let tutorialIntroText = KineoColors(name: "Tutorial Intro Text")
  public static let webControlTint = KineoColors(name: "Web Control Tint")
  public static let backgrounds = KineoImages(name: "Backgrounds")
  public static let support = KineoImages(name: "Support")
  public static let watermarkRemove = KineoImages(name: "WatermarkRemove")
  public static let zoom = KineoImages(name: "Zoom")
  public static let launchStoryboardImage = KineoImages(name: "Launch Storyboard Image")
  public static let blackHighlighter = KineoImages(name: "Black Highlighter")
  public static let debigulator = KineoImages(name: "Debigulator")
  public static let scrawl = KineoImages(name: "Scrawl")
  public static let watermark = KineoImages(name: "Watermark")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class KineoColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension KineoColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: KineoColors) {
    let bundle = KineoResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

public struct KineoImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = KineoResources.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

public extension KineoImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the KineoImages.image property")
  convenience init?(asset: KineoImages) {
    #if os(iOS) || os(tvOS)
    let bundle = KineoResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:enable all
// swiftformat:enable all
