$ErrorActionPreference = "Stop"

Invoke-Expression "env NSUnbufferedIO=YES xcodebuild -workspace ./Kineo.xcworkspace/ -scheme `"Kineo (visionOS)`" -derivedDataPath ./DerivedData -destination 'generic/platform=visionOS' -archivePath ./build/KineoVision.xcarchive archive | xcbeautify"

Invoke-Expression "xcrun xcodebuild -exportArchive -exportOptionsPlist ./scripts/export.plist -archivePath ./build/KineoVision.xcarchive -exportPath build"

Invoke-Expression "xcrun altool --upload-app -f ./build/Kineo.ipa -t visionOS --apiKey DXA442739T --apiIssuer 69a6de72-7555-47e3-e053-5b8c7c11a4d1"
