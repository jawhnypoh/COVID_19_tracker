// Vaccine Web Screen

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class VaccineWebViewState extends State<VaccineWebView> {
  String vaccineURL;
  String name, address;

  VaccineWebViewState(this.vaccineURL, this.name, this.address);

  Widget _buildAddressWidget() {
    return Container(
        padding: const EdgeInsets.all(25.0),
        child: Center(
            child: Column(
                children: <Widget>[
                  Text(address,
                      style: const TextStyle(fontSize: 25.0)),
                ]
            )
        )
    );
  }

  Widget _buildWebView() {
    return Container(
      child: WebviewScaffold(
        url: vaccineURL,
        withJavascript: true,
        hidden: true,
        withZoom: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(name),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildAddressWidget(),
              _buildWebView()
            ],
          ),
        ),
      ),
    );
  }
}

class VaccineWebView extends StatefulWidget {
  // Declare String variables
  final String vaccineURL;
  final String name, address;

  // Require in constructor
  VaccineWebView({Key key, @required this.vaccineURL, @required this.name,
    @required this.address}) : super(key : key);

  @override
  VaccineWebViewState createState() => VaccineWebViewState(vaccineURL, name, address);
}