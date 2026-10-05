import 'package:flutter/material.dart';
import 'main_app_bar.dart';

class TrainAppScaffold extends StatelessWidget {
  final String appTitle;
  final Widget widgetBody;

  const TrainAppScaffold ({
    super.key,
    required this.appTitle,
    required this.widgetBody,

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrainAppTitle(
        appTitle: appTitle,
      ),
      backgroundColor: Colors.black12,
      body: widgetBody,
      // bottomNavigationBar: , -- TO DO, add as param option for main page
    );
  }
}