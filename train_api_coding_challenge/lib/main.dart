import 'package:flutter/material.dart';
import 'package:train_api_coding_challenge/Runtime/main_providers.dart';
import 'package:train_api_coding_challenge/UI/Views/Main_Screen/live_train_map.dart';

void main() {
  runApp( 
    const ProviderRuntime(
      mainWidget: LiveTrainMap()
    )
  );
}

