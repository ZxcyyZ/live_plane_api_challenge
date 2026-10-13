
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plane_api_coding_challenge/Data/API_Models/live_plane_api_service.dart';
import 'package:plane_api_coding_challenge/Data/Repositories/live_plane_repository.dart';
import 'package:plane_api_coding_challenge/UI/Views/Main_Screen/view_models/live_plane_map_view_model.dart';

class ProviderRuntime extends StatelessWidget {
    final Widget mainWidget;

    const ProviderRuntime({super.key, required this.mainWidget});
    @override
    Widget build(BuildContext context) {
        //Build API & Data models first then viewModels
        return MultiProvider(
          providers: [
            Provider(create: (_) => LivePlaneApiService(http.Client())),
            Provider(create: (context) => LivePlaneRepository(context.read<LivePlaneApiService>())),
            ChangeNotifierProvider<LivePlanemapViewModel>(
              create: (context) => LivePlanemapViewModel(context.read<LivePlaneRepository>())
            ),
        ],
        builder: (context, child) {
          return mainWidget;
        },
      );
    }
}