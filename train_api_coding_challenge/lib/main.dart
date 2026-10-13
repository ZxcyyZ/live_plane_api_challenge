import 'package:flutter/material.dart';
import 'package:plane_api_coding_challenge/Runtime/main_providers.dart';
import 'package:plane_api_coding_challenge/UI/Views/Main_Screen/live_plane_map.dart';

void main() {
  runApp( 
    const ProviderRuntime(
      mainWidget: MaterialApp(
        home: LivePlaneMap(),
      )
    )
  );
}

