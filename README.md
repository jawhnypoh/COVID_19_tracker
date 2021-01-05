# COVID-19 Dashboard

A cross platform application that visualizes data from a variety of API sources, provides the latest news, and supplies acute information related to the 2019 Novel Coronavirus (COVID-19) Pandemic. This application was developed using the [Flutter SDK](https://flutter.dev/), and is compatible with both iOS and Android devices. 

![COVID-19 Dashboard Screenshots](https://i.imgur.com/g2iQW8c.png)

![Build](https://img.shields.io/badge/build-passing-brightgreen)
![iOS](https://img.shields.io/badge/iOS-10%20-blue?logo=Apple)
![Android](https://img.shields.io/badge/Android-6-blue?logo=Android&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-1.22.5-orange?logo=Flutter&logoColor=white)


## Meta
-  **State:** Release v3.0.0
- **Point People:** [@jawhnypoh](https://github.com/jawhnypoh)

## Features
- **Cross Platform:** Designed to be natively compatible with both iOS and Android devices
- **Updated Data:** The most up to date data provided by a number of sources
- **Statistics:** Statistics for global, country specific, or US state and county specific cases 
- **Color Coded:** Color coded statistics for Tested, Confirmed, Active, Deaths, Critical, Recovered, and many more
- **Charts:** Pie Chart showing percentages, Line Chart showing historical data, Bar Chart showing the most affected countries
- **News:** Get the latest on COVID related news, tapping on a news article leads to a webview of that article via the URL
- **Testing Centers:** NEW! Find COVID testing center locations for any US state on within a map view with Google Maps

## Potential Future Features:
- **Swipe to Refresh:** Swiping down from any of the detail screens will cause the page to refresh with new data
- **Murica Tab:** Current tab is only for showing US States data; allow the user to choose/search for provinces or counties of other countries instead (dependent on API availability)
- **Vaccine Data:** Current data on vaccines are limited, will plan to eventually add a screen on vaccine related information 

## Credits
### Data
* Johns Hopkins University Center for Systems Science and Engineering ([JHU CSSE](https://github.com/CSSEGISandData/COVID-19))
* World Meters Coronavirus Update ([WorldMeters](https://www.worldometers.info/coronavirus/))
* disease.sh API ([disease.sh](https://disease.sh/))
* r/Coronavirus Subreddit ([r/Coronavirus](https://www.reddit.com/r/Coronavirus/))
* covidtracking.com API ([covidtracking.com](https://covidtracking.com/data))
* ncov19.us API ([ncov19.us](https://covid19-us-api.herokuapp.com))
* sheetlabs NCOR API ([sheetlabs NCOR](https://app.sheetlabs.com/#/services/doc/NCOR/covidtestcentersinUS))

### Libraries
* [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter) for icons 
* [Dio](https://pub.dev/packages/dio) for handling API and asynchronous calls 
* [Intl](https://pub.dev/packages/intl) for various internationalization and localization conversions
* [Jiffy](https://pub.dev/packages/jiffy) for parsing and converting dates 
* [charts_flutter](https://pub.dev/packages/charts_flutter) for drawing charts
* [flutter_webview_plugin](https://pub.dev/packages/flutter_webview_plugin) for communicating with native webviews
* [us_states](https://pub.dev/packages/us_states) for converting state abbreviations to full names
* [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) for adding icons to iOS and Android version of the application
* [auto_size_text](https://pub.dev/packages/auto_size_text) for auto sizing statistics when they become too big for their specified space 
* [google_maps_flutter](https://pub.dev/packages/google_maps_flutter) for adding Google Maps with markers into the application

