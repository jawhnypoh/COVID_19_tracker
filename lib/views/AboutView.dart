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
                _buildAboutApp(),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                const Divider(color: Colors.grey),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                _buildAboutDisease(),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                const Divider(color: Colors.grey),
                const Padding(padding: EdgeInsets.only(top: 10.0)),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: const Text('Version 1.0.0', style: TextStyle(color: Colors.grey)),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
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
          Text('This COVID-19 Dashboard efficiently integrates data from a variety of API sources '
              'and generates colorful statistics for the 2019 Novel Coronavirus. '
              'Data is pulled from following sources: ',
              style: TextStyle(color: Colors.grey[350], fontSize: 20.0),
              textAlign: TextAlign.left),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          Text('• Johns Hopkins University CSSE',
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
          Text('• Coronavirus smartable API',
              style: TextStyle(color: Colors.grey[350], fontSize: 20.0),
              textAlign: TextAlign.left),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          Text('• covidtracking.com API',
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
            Text('COVID-19 is caused by the SARS-CoV-2 coronavirus. '
                'Older adults and those with underlying '
                'medical conditions appear to be most at risk. ', style: TextStyle(color: Colors.grey[350], fontSize: 20.0)),
            const Padding(padding: EdgeInsets.only(top: 30.0)),
            Text('What are the symptoms?',
              style: TextStyle(color: Colors.grey[350], fontWeight: FontWeight.bold, fontSize: 25.0),
              textAlign: TextAlign.left,
            ),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            Text('Symptoms may appear between a 2-14 day period after exposure. '
                'The most common symtoms are dry coughs or shortness of breath. '
                'If you are experiencing extreme symptoms, please seek medical '
                'attention immediately.', style: TextStyle(color: Colors.grey[350], fontSize: 20.0)),
          ],
      )
    );
  }
}
