# Weatherton

## Overview

Weatherton is a client to [WeatherAPI](https://www.weatherapi.com).

<img src="https://github.com/user-attachments/assets/4f80641a-59e4-460a-8331-8cc20eee5af5" width="240"> <img src="https://github.com/user-attachments/assets/3707fae5-4e56-4f9d-b9cb-aa0589d9bdd9" width="240"> <img src="https://github.com/user-attachments/assets/ddbd1b84-ffe6-468e-976a-da300bd6965a" width="240">

## Setup

### Requirements

- Xcode 15.4
- iOS 17

### Build steps

1. Clone the repo.
2. Run `./Scripts/setup-secrets.sh` from the local repository's root directory and enter the WeatherAPI key when prompted. A `Secrets.swift` file will be generated as a build phase.
3. Open `Weatherton.xcodeproj`.
4. Run the app.

## Discussion

### Dependencies

- [SwiftLint](https://github.com/realm/SwiftLint)

### Architecture

![Document systems](https://github.com/user-attachments/assets/f414b0b6-77d5-4844-a36a-5e29636f920c)

- SwiftUI with MVVM
- SPM for dependencies
- Service models are isolated to the networking component and are converted into DTOs.
- DTOs are formatted for the UI in "Formatted.." models (FormattedCurrentWeather, FormattedForecast).

### Objectives

When building this app it was important to me to create a solid app architecture that wouldn't just support the features I completed but would also be a good foundation for an expansion of further features. Also important was to show a clean app design that highlights the important data and doesn't get in the way or distract the user.

### Supported features

- Search global cities and view their current weather and forecast
- Current weather includes
	- Apparent temperature, condition description, humidity, visibility, and wind
- 24 hour forecast with temperature and condition
- Daily forecast with temperature range and condition
- Save location 
- Locale support of weather data units (Celsius/Fahrenheit/Kelvin, Kilometers/Miles, etc)
- Tailored VoiceOver support
- Dynamic Type support
- Data caching according to HTTP headers

### Where to go next

These are some of the things I would focus on if I continued developing this app.

#### Testing

- Add test coverage for model conversion.
- Add testing of views leveraging [ViewInspector](https://github.com/nalexn/ViewInspector).
- Add testing of view models.
- Investigate using fakes in the UI tests to prevent unnecessary API calls and improve reliability.

#### WeatherAPI

- Improve error handling of the WeatherAPI specific error codes (eg: disabled API key, API key exceeded monthly quota, no access to resource).

#### App refinement

- Fix local time of hourly forecasts for locations not in the user's current time zone.
- Add view placeholders when data is loading and not yet present rather than a simple loading indicator.
- Refine overall design including the contrast and legibility between the color gradients and the content and weather symbols.

#### Xcode Project

- Use a project build tool like [XcodeGen](https://github.com/yonaskolb/XcodeGen) or [Tuist](https://github.com/tuist/tuist) so the `.xcodeproj` file can be removed from git as the changes are difficult to review. This will also assist with getting the generated `Secrets.swift` file included in the project file so it doesn't appear as missing even though it exists in the file structure.
- Move inline strings for SF Symbol names into some single type or use a package like [SFSafeSymbols](https://github.com/SFSafeSymbols/SFSafeSymbols).

#### New features

- More comprehensive weather data on detail page
- Historical weather data report
- Device location integration
- Home screen widget
- Network listener to handle connectivity status
- Reorder locations support
- Improved add location UX flow
- 3D weather visualization

---

Still reading? Thanks for taking the time to thoroughly review my work! I hope we get an opportunity to discuss it together.
