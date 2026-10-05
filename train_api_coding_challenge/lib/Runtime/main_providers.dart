
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:train_api_coding_challenge/Data/API_Models/live_train_api_service.dart';
import 'package:train_api_coding_challenge/Data/Repositories/live_train_repository.dart';
import 'package:train_api_coding_challenge/UI/Views/Main_Screen/view_models/live_train_map_view_model.dart';

class ProviderRuntime extends StatelessWidget {
    final Widget mainWidget;

    const ProviderRuntime({super.key, required this.mainWidget});

    @override
    Widget build(BuildContext context) {
        //Build API & Data models first then viewModels
        return MultiProvider(
          providers: [
            Provider(create: (_) => LiveTrainApiService(http.Client())),
            Provider(create: (context) => LiveTrainRepository(context.read<LiveTrainApiService>())),
            ChangeNotifierProvider<LiveTrainmapViewModel>(
              create: (context) => LiveTrainmapViewModel(context.read<LiveTrainRepository>())
            ),
        ],
        builder: (context, child) {
          return mainWidget;
        },
      );
    }
}