# COVID-19 Dashboard

A cross platform application that efficiently integrates data from a variety of API sources and generates colorful and useful statistics for the 2019 Novel Coronavirus (COVID-19). This application was developed using [Flutter](https://flutter.dev/), and is compatible with both iOS and Android devices. 

![COVID-19 Dashboard Screenshots](https://i.imgur.com/g2iQW8c.png)

## Meta
-  **State:** Release v1.1.0
- **Point People:** [@jawhnypoh](https://github.com/jawhnypoh)

## Features
- **Cross Platform:** This application was designed from the ground up to run on both iOS and Android devices
- **Updated Data:** The most updated data provided by various data sources
- **Statistics:** Statistics for global, country specific, or US state specific cases 
- **Color Coded:** Color coded statistics for Tested, Confirmed, Active, Deaths, Critical, and Recovered cases 
- **Charts:** Pie Chart showing percentages, Line Chart showing historical data, Bar Chart showing the most affected countries
- **News:** Get the latest on COVID related news, tapping on a news article leads to a webview of that article via the URL

## Potential Future Features:
- **Swipe to Refresh:** Swiping down from any of the detail screens will cause the page to refresh with new data
- **Murica Tab:** Current tab is only for showing US States data; allow the user to choose/search for provinces or counties of other countries instead (dependent on API availability)

## Credits
### Data
* Johns Hopkins University Center for Systems Science and Engineering ([JHU CSSE](https://github.com/CSSEGISandData/COVID-19))
* World Meters Coronavirus Update ([WorldMeters](https://www.worldometers.info/coronavirus/))
* disease.sh API ([disease.sh](https://disease.sh/))
* r/Coronavirus Subreddit ([r/Coronavirus](https://www.reddit.com/r/Coronavirus/))
* covidtracking.com API ([covidtracking.com](https://covidtracking.com/data))

### Libraries
* [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter) for icons 
* [Dio](https://pub.dev/packages/dio) for handling API and asynchronous calls 
* [Intl](https://pub.dev/packages/intl) for various internationalization and localization conversions
* [Jiffy](https://pub.dev/packages/jiffy) for parsing and converting dates 
* [charts_flutter](https://pub.dev/packages/charts_flutter) for drawing charts
* [flutter_webview_plugin](https://pub.dev/packages/flutter_webview_plugin) for communicating with native webviews
* [us_states](https://pub.dev/packages/us_states) for converting state abbreviations to full names
* [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) for adding icons to iOS and Android version of the application

