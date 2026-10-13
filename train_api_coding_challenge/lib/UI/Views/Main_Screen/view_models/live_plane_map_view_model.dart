
import 'package:flutter/material.dart';
import 'package:plane_api_coding_challenge/Data/Repositories/live_plane_repository.dart';

class LivePlanemapViewModel extends ChangeNotifier {
  final LivePlaneRepository _repository;
 //comment
  LivePlanemapViewModel(
    this._repository
  );
}