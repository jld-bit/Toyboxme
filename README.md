# ToyBox Me (SwiftUI, iPhone Only)

ToyBox Me is an iPhone-only SwiftUI app that creates an original toy-box style portrait from a selfie using an external image generation service abstraction.

## Features
- Onboarding flow
- Selfie picker (single photo)
- Prompt builder with presets: Explorer, Retro Hero, Office Legend, Athlete, Musician, Sci-Fi
- Editable character name and accessory labels
- Packaging color theme picker
- Preview and async generation states
- Retry handling and error surfaces
- Save to Photos
- Share sheet (ShareLink)
- Local generation history persistence
- Privacy-oriented permission handling
- Accessibility labels and readable controls

## Project Structure

```
ToyBoxMe/
  App/
  Models/
  ViewModels/
  Views/
    Components/
    Screens/
  Services/
  Networking/
  Utilities/
  Config/
  Resources/
```

## Setup
1. Open the project folder in Xcode and create an iOS App target named **ToyBox Me** if not already created.
2. Add all files from `ToyBoxMe/` into the app target.
3. Copy `ToyBoxMe/Config/APIKeys.xcconfig.example` to `ToyBoxMe/Config/APIKeys.xcconfig`.
4. Add `ToyBoxMe/Config/APIKeys.xcconfig` to your Build Settings as a configuration file.
5. Set:
   - `TOYBOX_API_BASE_URL`
   - `TOYBOX_API_KEY`
6. Ensure `Info.plist` uses those variables (already configured in `ToyBoxMe/Resources/Info.plist`).
7. Build and run on iPhone simulator or device.

## API Service Abstraction
- `ToyPortraitGenerating` protocol defines portrait generation.
- `MockToyPortraitService` simulates responses for development.
- `RealToyPortraitService` is a production placeholder with API client integration points.

## Architecture Summary
- MVVM with service injection through `AppContainer`.
- Network layer: `APIClient` + `APIEndpoint`.
- Persistence: `LocalGenerationHistoryStore` stores local JSON in app documents directory.
- Caching: in-memory `ImageCache` using `NSCache`.

## Safety, Legal, and Compliance Note
Production use requires:
- properly licensed image generation API usage,
- original prompts and output handling,
- compliance with Apple App Store Review Guidelines,
- compliance with privacy law and intellectual-property law,
- strict avoidance of copyrighted characters, celebrity likenesses, trademarks, toy brand packaging, logos, or protected franchise styles.

## App Store Submission Checklist
- [ ] Unique app metadata, screenshots, and privacy policy URL prepared
- [ ] `NSPhotoLibraryUsageDescription` and `NSPhotoLibraryAddUsageDescription` verified
- [ ] Real API provider contract, moderation, and abuse handling in place
- [ ] Error states and offline behavior tested
- [ ] Accessibility pass (VoiceOver, Dynamic Type, contrast)
- [ ] Performance tested on low-memory devices
- [ ] Legal review for prompts, output policy, and IP constraints
- [ ] App Privacy nutrition labels completed in App Store Connect
- [ ] Final QA on TestFlight complete

## App Icon Concept
Create a vibrant rounded-square icon featuring:
- a stylized toy package with a smiling character silhouette,
- colorful gradient backdrop (pink → orange → violet),
- small sparkle accents for creativity,
- clean high-contrast shape language for legibility at small sizes,
- no branded marks or third-party logos.

