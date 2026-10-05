import 'dart:io';

import 'package:http/http.dart' as http;

class LiveTrainApiService {
  final http.Client _client;

   LiveTrainApiService (
    this._client,
  );
}