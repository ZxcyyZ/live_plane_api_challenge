import 'package:flutter/material.dart';
import 'main_app_bar.dart';

class PlaneAppScaffold extends StatelessWidget {
  final String appTitle;
  final Widget widgetBody;

  const PlaneAppScaffold ({
    super.key,
    required this.appTitle,
    required this.widgetBody,

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlaneAppTitle(
        appTitle: appTitle,
      ),
      backgroundColor: Colors.white,
      body: widgetBody,
      // bottomNavigationBar: , -- TO DO, add as param option for main page
    );
  }
}