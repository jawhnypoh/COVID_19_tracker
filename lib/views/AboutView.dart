// About Screen

import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('About'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                Container(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/images/covid_19_dashboard_icon.png')
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                _buildAboutApp(),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                const Divider(color: Colors.grey),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                _buildAboutDisease(),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                const Divider(color: Colors.grey),
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Version 3.0.0', style: TextStyle(color: Colors.grey)),
                      Text('Developed by Johnny Po', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutApp() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Insert icon here later
          Text('The COVID-19 Dashboard application visualizes data from a variety of API sources, '
              'provides the latest news, and supplies acute information related to the 2019 Novel Coronavirus Pandemic. '
              'Data is pulled from following sources: ',
              style: TextStyle(color: Colors.grey[350], fontSize: 20.0),
              textAlign: TextAlign.left),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          Text('• Johns Hopkins University CSSE',
              style: TextStyle(color: Colors.grey[350], fontSize: 20.0),
              textAlign: TextAlign.left),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          Text('• New York Times COVID-19 Data',
              style: TextStyle(color: Colors.grey[350], fontSize: 20.0),
              textAlign: TextAlign.left),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          Text('• World Meters Coronavirus Update',
              style: TextStyle(color: Colors.grey[350], fontSize: 20.0),
              textAlign: TextAlign.right),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          Text('• disease.sh API',
              style: TextStyle(color: Colors.grey[350], fontSize: 20.0),
              textAlign: TextAlign.left),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          Text('• corona-api API',
              style: TextStyle(color: Colors.grey[350], fontSize: 20.0),
              textAlign: TextAlign.left),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          Text('• r/Coronavirus subreddit',
              style: TextStyle(color: Colors.grey[350], fontSize: 20.0),
              textAlign: TextAlign.left),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          Text('• covidtracking.com API',
              style: TextStyle(color: Colors.grey[350], fontSize: 20.0),
              textAlign: TextAlign.left),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          Text('• covid19-us API',
              style: TextStyle(color: Colors.grey[350], fontSize: 20.0),
              textAlign: TextAlign.left),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          Text('• vaccinespotter API',
              style: TextStyle(color: Colors.grey[350], fontSize: 20.0),
              textAlign: TextAlign.left)
        ],
      ),
    );
  }

  Widget _buildAboutDisease() {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('What is COVID-19?',
                style: TextStyle(color: Colors.grey[350], fontWeight: FontWeight.bold, fontSize: 25.0),
              textAlign: TextAlign.left,
            ),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Text('COVID-19 is the illness caused by the SARS-CoV-2 coronavirus. '
                'Older adults and individuals with underlying '
                'medical conditions appear to be most at risk. ', style: TextStyle(color: Colors.grey[350], fontSize: 20.0)),
            const Padding(padding: EdgeInsets.only(top: 30.0)),
            Text('What are the symptoms?',
              style: TextStyle(color: Colors.grey[350], fontWeight: FontWeight.bold, fontSize: 25.0),
              textAlign: TextAlign.left,
            ),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Text('Symptoms may appear between a 2 - 14 day period after exposure. '
                'The most common symptoms are dry coughs or shortness of breath. '
                'If you are experiencing extreme symptoms, please seek medical '
                'attention immediately.', style: TextStyle(color: Colors.grey[350], fontSize: 20.0)),
            const Padding(padding: EdgeInsets.only(top: 30.0)),
            Text('How can I help stop the spread?',
              style: TextStyle(color: Colors.grey[350], fontWeight: FontWeight.bold, fontSize: 25.0),
              textAlign: TextAlign.left,
            ),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Text('The best way to prevent illness is to avoid any exposure to the virus. These methods include: ',
                style: TextStyle(color: Colors.grey[350], fontSize: 20.0)),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Text('• Wearing a mask as often as you can, especially around others',
                style: TextStyle(color: Colors.grey[350], fontSize: 20.0),
                textAlign: TextAlign.left),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Text('• Obeying social distancing measures and avoiding large gatherings',
                style: TextStyle(color: Colors.grey[350], fontSize: 20.0),
                textAlign: TextAlign.left),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Text('• Washing your hands often',
                style: TextStyle(color: Colors.grey[350], fontSize: 20.0),
                textAlign: TextAlign.left),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Text('• Staying home as much as possible',
                style: TextStyle(color: Colors.grey[350], fontSize: 20.0),
                textAlign: TextAlign.left),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Text('• Avoiding contact with people that are sick or may have been exposed',
                style: TextStyle(color: Colors.grey[350], fontSize: 20.0),
                textAlign: TextAlign.left),
          ],
      )
    );
  }
}
