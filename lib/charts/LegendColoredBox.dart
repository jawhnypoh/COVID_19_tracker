// Colored Circle Class
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LegendColoredBox extends StatelessWidget {
  final String text;
  final Color color;

  LegendColoredBox({this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(FontAwesomeIcons.solidCircle, color: this.color, size: 15.0,),
        Text('  ' + this.text, style: TextStyle(color: Colors.grey[350]),)
      ],
    );
  }
}