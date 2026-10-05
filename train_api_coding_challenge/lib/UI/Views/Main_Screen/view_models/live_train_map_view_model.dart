
import 'package:flutter/material.dart';
import 'package:train_api_coding_challenge/Data/Repositories/live_train_repository.dart';

class LiveTrainmapViewModel extends ChangeNotifier {
  final LiveTrainRepository _repository;
 //comment
  LiveTrainmapViewModel(
    this._repository
  );
}