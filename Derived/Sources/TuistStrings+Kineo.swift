// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum KineoStrings {
  public enum InfoPlist {
    /// Kineo would like access to add to (not read from) your photo library in order to save videos of your animations.
    public static let nsPhotoLibraryAddUsageDescription = KineoStrings.tr("InfoPlist", "NSPhotoLibraryAddUsageDescription")
  }
  public enum Localizable {
    public enum BackgroundButton {
      /// Canvas Background
      public static let accessibilityLabel = KineoStrings.tr("Localizable", "BackgroundButton.accessibilityLabel")
      /// Color
      public static let colorItemTitle = KineoStrings.tr("Localizable", "BackgroundButton.colorItemTitle")
      /// Image
      public static let imageItemTitle = KineoStrings.tr("Localizable", "BackgroundButton.imageItemTitle")
      /// Change Canvas Background…
      public static let menuTitle = KineoStrings.tr("Localizable", "BackgroundButton.menuTitle")
    }
    public enum BackgroundImageNotPurchasedAlertController {
      /// Never Mind
      public static let dismissButton = KineoStrings.tr("Localizable", "BackgroundImageNotPurchasedAlertController.dismissButton")
      /// Hide This Feature
      public static let hideButton = KineoStrings.tr("Localizable", "BackgroundImageNotPurchasedAlertController.hideButton")
      /// Learn More…
      public static let learnMoreButton = KineoStrings.tr("Localizable", "BackgroundImageNotPurchasedAlertController.learnMoreButton")
      /// Changing the background image requires Kineo Pro, a one-time purchase.
      public static let message = KineoStrings.tr("Localizable", "BackgroundImageNotPurchasedAlertController.message")
      /// Requires Kineo Pro
      public static let title = KineoStrings.tr("Localizable", "BackgroundImageNotPurchasedAlertController.title")
    }
    public enum BackgroundsPurchaseMarketingItem {
      /// A change of scenery.
      public static let header = KineoStrings.tr("Localizable", "BackgroundsPurchaseMarketingItem.header")
      /// Use photos or screenshots as the backdrop for your animations.
      public static let text = KineoStrings.tr("Localizable", "BackgroundsPurchaseMarketingItem.text")
    }
    public enum ContactMailViewController {
      /// Hello!
      public static let emailSubject = KineoStrings.tr("Localizable", "ContactMailViewController.emailSubject")
    }
    public enum DisplayModeButton {
      /// Compare
      public static let compareItemTitle = KineoStrings.tr("Localizable", "DisplayModeButton.compareItemTitle")
      /// Draw
      public static let drawItemTitle = KineoStrings.tr("Localizable", "DisplayModeButton.drawItemTitle")
      /// Edit
      public static let framesItemTitle = KineoStrings.tr("Localizable", "DisplayModeButton.framesItemTitle")
      /// Play
      public static let playItemTitle = KineoStrings.tr("Localizable", "DisplayModeButton.playItemTitle")
    }
    public enum DrawingView {
      /// Canvas
      public static let accessibilityLabel = KineoStrings.tr("Localizable", "DrawingView.accessibilityLabel")
    }
    public enum EditingViewController {
      /// Back One Page
      public static let backKeyCommandTitle = KineoStrings.tr("Localizable", "EditingViewController.backKeyCommandTitle")
      /// Share Animation
      public static let exportKeyCommandTitle = KineoStrings.tr("Localizable", "EditingViewController.exportKeyCommandTitle")
      /// Made with Kineo: https://kineo.app
      public static let exportPromoText = KineoStrings.tr("Localizable", "EditingViewController.exportPromoText")
      /// Forward One Page
      public static let forwardKeyCommandTitle = KineoStrings.tr("Localizable", "EditingViewController.forwardKeyCommandTitle")
      /// Return to Gallery
      public static let galleryKeyCommandTitle = KineoStrings.tr("Localizable", "EditingViewController.galleryKeyCommandTitle")
      /// Play Animation
      public static let playKeyCommandTitle = KineoStrings.tr("Localizable", "EditingViewController.playKeyCommandTitle")
    }
    public enum ExportButton {
      /// Share
      public static let accessibilityLabel = KineoStrings.tr("Localizable", "ExportButton.accessibilityLabel")
    }
    public enum ExportEditingViewController {
      /// Share
      public static let shareTitle = KineoStrings.tr("Localizable", "ExportEditingViewController.shareTitle")
    }
    public enum ExportSettingsActivity {
      /// Share Settings
      public static let activityTitle = KineoStrings.tr("Localizable", "ExportSettingsActivity.activityTitle")
    }
    public enum ExportSettingsBackgroundContentItem {
      public enum Dark {
        /// Dark
        public static let title = KineoStrings.tr("Localizable", "ExportSettingsBackgroundContentItem.dark.title")
      }
      public enum Light {
        /// Light
        public static let title = KineoStrings.tr("Localizable", "ExportSettingsBackgroundContentItem.light.title")
      }
      public enum Unspecified {
        /// Use System Setting (%@)
        public static func title(_ p1: Any) -> String {
          return KineoStrings.tr("Localizable", "ExportSettingsBackgroundContentItem.unspecified.title", String(describing: p1))
        }
      }
    }
    public enum ExportSettingsBackgroundContentSection {
      /// Video Background
      public static let header = KineoStrings.tr("Localizable", "ExportSettingsBackgroundContentSection.header")
    }
    public enum ExportSettingsDurationContentItem {
      public enum FiveSeconds {
        /// 5 seconds
        public static let title = KineoStrings.tr("Localizable", "ExportSettingsDurationContentItem.fiveSeconds.title")
      }
      public enum TenSeconds {
        /// 10 seconds
        public static let title = KineoStrings.tr("Localizable", "ExportSettingsDurationContentItem.tenSeconds.title")
      }
      public enum ThreeSeconds {
        /// 3 seconds
        public static let title = KineoStrings.tr("Localizable", "ExportSettingsDurationContentItem.threeSeconds.title")
      }
    }
    public enum ExportSettingsDurationContentSection {
      /// Some social networks require a minimum video length to post. Kineo will play your entire animation enough times to meet the minimum length you choose.
      public static let footer = KineoStrings.tr("Localizable", "ExportSettingsDurationContentSection.footer")
      /// Minimum Length
      public static let header = KineoStrings.tr("Localizable", "ExportSettingsDurationContentSection.header")
    }
    public enum ExportSettingsShapeContentItem {
      public enum Landscape {
        /// Landscape
        public static let title = KineoStrings.tr("Localizable", "ExportSettingsShapeContentItem.landscape.title")
      }
      public enum Portrait {
        /// Portrait
        public static let title = KineoStrings.tr("Localizable", "ExportSettingsShapeContentItem.portrait.title")
      }
      public enum Square {
        /// Square
        public static let title = KineoStrings.tr("Localizable", "ExportSettingsShapeContentItem.square.title")
      }
      public enum SquarePlain {
        /// Square (No Frame)
        public static let title = KineoStrings.tr("Localizable", "ExportSettingsShapeContentItem.squarePlain.title")
      }
    }
    public enum ExportSettingsShapeContentSection {
      /// Video Shape
      public static let header = KineoStrings.tr("Localizable", "ExportSettingsShapeContentSection.header")
    }
    public enum ExportSettingsStyleContentItem {
      public enum Bounce {
        /// Bounce
        public static let title = KineoStrings.tr("Localizable", "ExportSettingsStyleContentItem.bounce.title")
      }
      public enum Loop {
        /// Loop
        public static let title = KineoStrings.tr("Localizable", "ExportSettingsStyleContentItem.loop.title")
      }
      public enum Standard {
        /// Play Once
        public static let title = KineoStrings.tr("Localizable", "ExportSettingsStyleContentItem.standard.title")
      }
    }
    public enum ExportSettingsStyleContentSection {
      /// Video Effect
      public static let header = KineoStrings.tr("Localizable", "ExportSettingsStyleContentSection.header")
    }
    public enum ExportSettingsViewController {
      /// Share
      public static let exportButtonTitle = KineoStrings.tr("Localizable", "ExportSettingsViewController.exportButtonTitle")
      /// Share Settings
      public static let navigationTitle = KineoStrings.tr("Localizable", "ExportSettingsViewController.navigationTitle")
    }
    public enum FilmStripView {
      /// Navigates and creates new pages
      public static let accessibilityHint = KineoStrings.tr("Localizable", "FilmStripView.accessibilityHint")
      /// Timeline
      public static let accessibilityLabel = KineoStrings.tr("Localizable", "FilmStripView.accessibilityLabel")
      /// Page %d of %d
      public static func accessibilityValueFormat(_ p1: Int, _ p2: Int) -> String {
        return KineoStrings.tr("Localizable", "FilmStripView.accessibilityValueFormat", p1, p2)
      }
    }
    public enum GalleryButton {
      /// Gallery
      public static let accessibilityLabel = KineoStrings.tr("Localizable", "GalleryButton.accessibilityLabel")
    }
    public enum GalleryDocumentCollectionViewCell {
      /// Animation
      public static let accessibilityLabel = KineoStrings.tr("Localizable", "GalleryDocumentCollectionViewCell.accessibilityLabel")
      /// Last modified on %@
      public static func accessibilityValueFormat(_ p1: Any) -> String {
        return KineoStrings.tr("Localizable", "GalleryDocumentCollectionViewCell.accessibilityValueFormat", String(describing: p1))
      }
    }
    public enum GalleryDocumentCollectionViewCellMenuConfigurationProvider {
      /// Delete
      public static let deleteMenuItemTitle = KineoStrings.tr("Localizable", "GalleryDocumentCollectionViewCellMenuConfigurationProvider.deleteMenuItemTitle")
      /// Share
      public static let exportMenuItemTitle = KineoStrings.tr("Localizable", "GalleryDocumentCollectionViewCellMenuConfigurationProvider.exportMenuItemTitle")
      /// Open in New Window
      public static let windowMenuItemTitle = KineoStrings.tr("Localizable", "GalleryDocumentCollectionViewCellMenuConfigurationProvider.windowMenuItemTitle")
    }
    public enum GalleryNewCollectionViewCell {
      /// New Animation
      public static let accessibilityLabel = KineoStrings.tr("Localizable", "GalleryNewCollectionViewCell.accessibilityLabel")
    }
    public enum GalleryViewController {
      /// Help
      public static let helpKeyCommandTitle = KineoStrings.tr("Localizable", "GalleryViewController.helpKeyCommandTitle")
      /// New Animation
      public static let newDocumentKeyCommandTitle = KineoStrings.tr("Localizable", "GalleryViewController.newDocumentKeyCommandTitle")
      /// Settings
      public static let settingsKeyCommandTitle = KineoStrings.tr("Localizable", "GalleryViewController.settingsKeyCommandTitle")
    }
    public enum HelpButton {
      /// Help
      public static let accessibilityLabel = KineoStrings.tr("Localizable", "HelpButton.accessibilityLabel")
    }
    public enum HideWatermarkToggleSwitch {
      /// Hide Watermark
      public static let title = KineoStrings.tr("Localizable", "HideWatermarkToggleSwitch.title")
    }
    public enum MenuButton {
      /// Menu
      public static let accessibilityLabel = KineoStrings.tr("Localizable", "MenuButton.accessibilityLabel")
      /// Change Background Color…
      public static let backgroundColorItemTitle = KineoStrings.tr("Localizable", "MenuButton.backgroundColorItemTitle")
      /// Change Background Image…
      public static let backgroundImageItemTitle = KineoStrings.tr("Localizable", "MenuButton.backgroundImageItemTitle")
      /// Share
      public static let exportItemTitle = KineoStrings.tr("Localizable", "MenuButton.exportItemTitle")
    }
    public enum PlayButton {
      /// Play
      public static let accessibilityLabel = KineoStrings.tr("Localizable", "PlayButton.accessibilityLabel")
    }
    public enum PlayButtonContextMenuConfigurationFactory {
      /// Bounce
      public static let bounceMenuItemTitle = KineoStrings.tr("Localizable", "PlayButtonContextMenuConfigurationFactory.bounceMenuItemTitle")
      /// Loop
      public static let loopMenuItemTitle = KineoStrings.tr("Localizable", "PlayButtonContextMenuConfigurationFactory.loopMenuItemTitle")
    }
    public enum PurchaseButton {
      /// Purchase
      public static let loadingTitle = KineoStrings.tr("Localizable", "PurchaseButton.loadingTitle")
      /// Purchased
      public static let purchasedTitle = KineoStrings.tr("Localizable", "PurchaseButton.purchasedTitle")
      /// Purchasing…
      public static let purchasingTitle = KineoStrings.tr("Localizable", "PurchaseButton.purchasingTitle")
      /// Purchase for %@
      public static func readyTitle(_ p1: Any) -> String {
        return KineoStrings.tr("Localizable", "PurchaseButton.readyTitle%@", String(describing: p1))
      }
    }
    public enum PurchaseMarketingButtonSubtitle {
      /// Unlock all of the features of Kineo.
      public static let text = KineoStrings.tr("Localizable", "PurchaseMarketingButtonSubtitle.text")
      /// Unlock all of the features of Kineo.\nJust %@.
      public static func text(_ p1: Any) -> String {
        return KineoStrings.tr("Localizable", "PurchaseMarketingButtonSubtitle.text%@", String(describing: p1))
      }
    }
    public enum PurchaseMarketingButtonTitle {
      /// Kineo Pro
      public static let text = KineoStrings.tr("Localizable", "PurchaseMarketingButtonTitle.text")
    }
    public enum PurchaseMarketingItem {
      public enum Support {
        /// Support the software arts.
        public static let header = KineoStrings.tr("Localizable", "PurchaseMarketingItem.support.header")
        /// Your support helps keep updates to Kineo coming.
        public static let text = KineoStrings.tr("Localizable", "PurchaseMarketingItem.support.text")
      }
      public enum Watermark {
        /// Ad? Subtracted.
        public static let header = KineoStrings.tr("Localizable", "PurchaseMarketingItem.watermark.header")
        /// Remove the Kineo ad from the bottom of shared videos.
        public static let text = KineoStrings.tr("Localizable", "PurchaseMarketingItem.watermark.text")
      }
      public enum Zoom {
        /// Embiggen your view.
        public static let header = KineoStrings.tr("Localizable", "PurchaseMarketingItem.zoom.header")
        /// Zoom the canvas to work on the finest details.
        public static let text = KineoStrings.tr("Localizable", "PurchaseMarketingItem.zoom.text")
      }
    }
    public enum PurchaseMarketingTopBarHeadlineLabel {
      /// Kineo Pro
      public static let text = KineoStrings.tr("Localizable", "PurchaseMarketingTopBarHeadlineLabel.text")
    }
    public enum PurchaseMarketingTopBarSubheadlineLabel {
      /// Unlock these powerful\nnew abilities for Kineo.
      public static let text = KineoStrings.tr("Localizable", "PurchaseMarketingTopBarSubheadlineLabel.text")
    }
    public enum PurchaseRestoreButton {
      /// Restore
      public static let title = KineoStrings.tr("Localizable", "PurchaseRestoreButton.title")
    }
    public enum RedoButton {
      /// Redo
      public static let accessibilityLabel = KineoStrings.tr("Localizable", "RedoButton.accessibilityLabel")
    }
    public enum ReleaseNotesItem {
      /// Version %@
      public static func subtitleFormat(_ p1: Any) -> String {
        return KineoStrings.tr("Localizable", "ReleaseNotesItem.subtitleFormat", String(describing: p1))
      }
    }
    public enum SettingsContentGenerator {
      /// Version %@
      public static func versionStringFormat(_ p1: Any) -> String {
        return KineoStrings.tr("Localizable", "SettingsContentGenerator.versionStringFormat%@", String(describing: p1))
      }
    }
    public enum SettingsContentProvider {
      public enum Item {
        /// Acknowledgements
        public static let acknowledgements = KineoStrings.tr("Localizable", "SettingsContentProvider.Item.acknowledgements")
        /// Contact the Developer
        public static let contact = KineoStrings.tr("Localizable", "SettingsContentProvider.Item.contact")
        /// Instagram
        public static let instagram = KineoStrings.tr("Localizable", "SettingsContentProvider.Item.instagram")
        /// What's New?
        public static let new = KineoStrings.tr("Localizable", "SettingsContentProvider.Item.new")
        /// Privacy Policy
        public static let privacy = KineoStrings.tr("Localizable", "SettingsContentProvider.Item.privacy")
        /// What's New?
        public static let releaseNotes = KineoStrings.tr("Localizable", "SettingsContentProvider.Item.releaseNotes")
        /// Twitch
        public static let twitch = KineoStrings.tr("Localizable", "SettingsContentProvider.Item.twitch")
        /// Twitter
        public static let twitter = KineoStrings.tr("Localizable", "SettingsContentProvider.Item.twitter")
        public enum Instagram {
          /// @kineoapp
          public static let subtitle = KineoStrings.tr("Localizable", "SettingsContentProvider.Item.instagram.subtitle")
        }
        public enum Twitch {
          /// @cocoatype
          public static let subtitle = KineoStrings.tr("Localizable", "SettingsContentProvider.Item.twitch.subtitle")
        }
        public enum Twitter {
          /// @kineoapp
          public static let subtitle = KineoStrings.tr("Localizable", "SettingsContentProvider.Item.twitter.subtitle")
        }
      }
      public enum Section {
        public enum OtherApps {
          /// Other Apps by Cocoatype
          public static let header = KineoStrings.tr("Localizable", "SettingsContentProvider.Section.otherApps.header")
        }
        public enum Social {
          /// Social Media
          public static let header = KineoStrings.tr("Localizable", "SettingsContentProvider.Section.social.header")
        }
        public enum WebURLs {
          /// Important Information
          public static let header = KineoStrings.tr("Localizable", "SettingsContentProvider.Section.webURLs.header")
        }
      }
    }
    public enum SettingsDoneButton {
      /// Done
      public static let label = KineoStrings.tr("Localizable", "SettingsDoneButton.label")
    }
    public enum SettingsViewController {
      /// Kineo Help
      public static let navigationTitle = KineoStrings.tr("Localizable", "SettingsViewController.navigationTitle")
    }
    public enum ToolsButton {
      /// Tool Picker
      public static let accessibilityLabel = KineoStrings.tr("Localizable", "ToolsButton.accessibilityLabel")
    }
    public enum TutorialIntroContinueButton {
      /// Continue
      public static let continueTitle = KineoStrings.tr("Localizable", "TutorialIntroContinueButton.continueTitle")
      /// Get Started
      public static let startTitle = KineoStrings.tr("Localizable", "TutorialIntroContinueButton.startTitle")
    }
    public enum TutorialIntroDismissButton {
      /// Skip Tour
      public static let title = KineoStrings.tr("Localizable", "TutorialIntroDismissButton.title")
    }
    public enum TutorialIntroView {
      /// Thanks for downloading Kineo!\n\nTo help get you started using Kineo to make animations, I’ve put together a short tour. If you’ve used Kineo before, or would rather just get started, feel free to skip it and jump right into action!\n\nEither way, I hope you have a great time using Kineo! If you have any questions or concerns, you can contact me from the help menu at any time.\n\n—Geoff, Kineo Developer
      public static let bodyText = KineoStrings.tr("Localizable", "TutorialIntroView.bodyText")
      /// Welcome to\nKineo
      public static let headerText = KineoStrings.tr("Localizable", "TutorialIntroView.headerText")
    }
    public enum TutorialOnboardingDrawPageView {
      /// Draw using your finger or Apple Pencil in the center canvas.\n\nWant to change color, pen type, or erase? Tap the $pencil.tip.crop.circle$ button to bring up the tool picker.\n\nWhen you’ve finished one page, tap $plus$ in the page strip to create another; the last few pages will appear faintly over your new one.
      public static let bodyText = KineoStrings.tr("Localizable", "TutorialOnboardingDrawPageView.bodyText")
      /// Draw
      public static let headerText = KineoStrings.tr("Localizable", "TutorialOnboardingDrawPageView.headerText")
    }
    public enum TutorialOnboardingPlayPageView {
      /// All of your pages are available in a strip on the screen. You can scroll them back and forth to preview your animation.\n\nTap the $play$ button to play your animation once, or double-tap it to play in a loop. You can hold down the button to choose between a normal loop and a “bounce” loop that reverses back to the beginning.
      public static let bodyText = KineoStrings.tr("Localizable", "TutorialOnboardingPlayPageView.bodyText")
      /// Play
      public static let headerText = KineoStrings.tr("Localizable", "TutorialOnboardingPlayPageView.headerText")
    }
    public enum TutorialOnboardingSharePageView {
      /// Tap the $square.and.arrow.up$ button to begin sharing your animation. Here, you can change how it looks:\n\nYou can change the shape of the video you share with $square$/$rectangle$/$rectangle.portrait$/$square.dashed$. Different shapes look better in different apps!\n\nYou can choose between looping and bouncing your animation with $arrow.2.circlepath$/$arrow.left.arrow.right$.
      public static let bodyText = KineoStrings.tr("Localizable", "TutorialOnboardingSharePageView.bodyText")
      /// Share
      public static let headerText = KineoStrings.tr("Localizable", "TutorialOnboardingSharePageView.headerText")
    }
    public enum UndoButton {
      /// Undo
      public static let accessibilityLabel = KineoStrings.tr("Localizable", "UndoButton.accessibilityLabel")
    }
    public enum UseLegacyIconItem {
      /// Use Legacy App Icon
      public static let title = KineoStrings.tr("Localizable", "UseLegacyIconItem.title")
    }
    public enum VideoProvider {
      /// Animation
      public static let metadataTitle = KineoStrings.tr("Localizable", "VideoProvider.metadataTitle")
    }
    public enum ZoomNotPurchasedAlertController {
      /// Never Mind
      public static let dismissButton = KineoStrings.tr("Localizable", "ZoomNotPurchasedAlertController.dismissButton")
      /// Hide This Feature
      public static let hideButton = KineoStrings.tr("Localizable", "ZoomNotPurchasedAlertController.hideButton")
      /// Learn More…
      public static let learnMoreButton = KineoStrings.tr("Localizable", "ZoomNotPurchasedAlertController.learnMoreButton")
      /// Zooming requires Kineo Pro, a one-time purchase.
      public static let message = KineoStrings.tr("Localizable", "ZoomNotPurchasedAlertController.message")
      /// Requires Kineo Pro
      public static let title = KineoStrings.tr("Localizable", "ZoomNotPurchasedAlertController.title")
    }
    public enum 🐎IconToggleSwitch {
      /// Use Legacy App Icon
      public static let title = KineoStrings.tr("Localizable", "🐎IconToggleSwitch.title")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension KineoStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = KineoResources.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
// swiftlint:enable all
// swiftformat:enable all
