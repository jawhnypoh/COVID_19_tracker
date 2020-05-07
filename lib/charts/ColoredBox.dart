// Colored Circle Class
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ColoredBox extends StatelessWidget {
  final String text;
  final Color color;

  ColoredBox({this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 10.0,
          height: 10.0,
          color: this.color,
        ),
        Text('  ' + this.text, style: TextStyle(color: Colors.grey[350]),)
      ],
    );
  }
}