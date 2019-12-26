
# SDWeather
SDWeather is a Mobile Coding Test app to display the weather forecast for the current city for 5 days 3 hours in a list and current weather for the searched cities. It's a simple app developed using MVVM architecture.

![ScreenShot](https://github.com/kvikas8/SDWeather/blob/stImages/SDweatherRec.gif)

## Installation

Clone the app using below command and simply open the xcodeproj file to run the app.

```bash
git clone https://github.com/kvikas8/SDWeather.git
```
## Testing
- Unit test cases are written using XCTest.
- All the view models have 100% coverage
- Simply press **Command + U** or select **Product > Test** from Xcode Menu to run tests.
- To see the code coverage report, run the test suite and open the **Report Navigator** on the left, select the report for the last test run, and open the **Coverage** tab at the top.
- Below is the screenshot of latest **Coverage**

![ScreenShot](https://github.com/kvikas8/SDWeather/blob/stImages/Coverage.png)

## Notes
- App only support portrait mode for now.
- App is only tested in iOS (iPhone 11 Simulator) due to time constraint.
- App will accept city one by one as of now. Support for accepting comma seperated cities is not developed yet due to time constraint.

## Needed Improvements
- UIEnhancements
- Proper Validation on entering cities.
- Error handling with proper error messages.
- Localizable strings
- Proper comments in the code to make it more understandable.
- Fastlane integration.
