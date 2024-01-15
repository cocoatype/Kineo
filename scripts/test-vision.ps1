$ErrorActionPreference = "Stop"

$jsonOutput = Invoke-Expression "xcrun simctl list devices --json" | Out-String

try {
    $parsedJson = $jsonOutput | ConvertFrom-Json
    $simUdid = $parsedJson.devices."com.apple.CoreSimulator.SimRuntime.xrOS-1-0"[0].udid
    $command = "env NSUnbufferedIO=YES xcodebuild -workspace ./Kineo.xcworkspace/ -scheme `"Kineo (visionOS)`" -derivedDataPath ./DerivedData -destination 'id=$simUdid' build | xcbeautify"

    Invoke-Expression $command
} catch {
    Write-Error "Failed to parse JSON: $_"
}
