import 'package:flutter/material.dart';
import 'main_app_bar.dart';

class WeightlyScaffold extends StatelessWidget {
  final VoidCallback? callbackNavigation;
  final List<Widget>? actionlist;
  final String appTitle;
  final Widget widgetBody;
  final bool burgerNavBool;

  const WeightlyScaffold ({
    super.key,
    required this.appTitle,
    required this.widgetBody,
    required this.burgerNavBool,
    this.callbackNavigation,
    this.actionlist,

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrainAppTitle(
        appTitle: appTitle,
        actionlist: actionlist,
        navigationCallback: callbackNavigation,
        burgerNav: burgerNavBool ,
      ),
      backgroundColor: Colors.black12,
      body: widgetBody,
      // bottomNavigationBar: , -- TO DO, add as param option for main page
    );
  }
}