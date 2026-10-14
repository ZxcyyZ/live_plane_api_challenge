// ignore_for_file: non_constant_identifier_names

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plane_api_coding_challenge/Data/API_Models/live_plane_api_service.dart';

class LivePlaneRepository {
  final LivePlaneApiService _apiService;

  LivePlaneRepository(
    this._apiService,
  );

  Future<PlaneData> fetchInitial (LatLngBounds bounds) async{
    final PlaneData planeData = await _apiService.fetchPlanes(bounds);
    return planeData;
  }
  
}

class PlaneData{
  final DateTime time;
  final List<PlaneStates> states;

  PlaneData({
    required this.time,
    required this.states,
  });

  factory PlaneData.fromJson(Map<String, dynamic> json){
    final rawStates = json['states'] as List<dynamic>;
    return PlaneData(
      time: DateTime.fromMillisecondsSinceEpoch((json['time'] as int ) * 1000),
      states: rawStates
          .map((e) => PlaneStates.fromList(e as List<dynamic>))
          .toList()
    );
  }
}

class PlaneStates{
  final String? icao24;
  final String? callsign;
  final String? orgin_country;
  final int? time_position;
  final int? last_contact;
  final double? longitude;
  final double? latitude;
  final double? baro_altitude;
  final bool? on_ground;
  final double? velocity;
  final double? true_track;
  final double? vertical_rate;
  final List<int>? sensors;
  final double? geo_altitude;
  final String? squawk;
  final bool? spi;
  final int? position_source;
  final int? category;


  PlaneStates({
    required this.icao24,
    required this.callsign,
    required this.orgin_country,
    required this.time_position,
    required this.last_contact,
    required this.longitude,
    required this.latitude,
    required this.baro_altitude,
    required this.on_ground,
    required this.velocity,
    required this.true_track,
    required this.vertical_rate,
    required this.sensors,
    required this.geo_altitude,
    required this.squawk,
    required this.spi,
    required this.position_source,
    required this.category,
  });

  factory PlaneStates.fromList(List<dynamic> states){
    return PlaneStates(
      icao24: states[0] as String?,
      callsign: (states[1] as String?)?.trim(),
      orgin_country: states[2] as String?,
      time_position: states[3] as int?,
      last_contact: states[4] as int?,
      longitude: (states[5] as num?)?.toDouble(),
      latitude: (states[6] as num?)?.toDouble(),
      baro_altitude: (states[7] as num?)?.toDouble(),
      on_ground: states[8] as bool?,
      velocity: (states[9] as num?)?.toDouble(),
      true_track: (states[10] as num?)?.toDouble(),
      vertical_rate: (states[11] as num?)?.toDouble(),
      sensors:  (states[12] as List?)?.cast<int>(),
      geo_altitude: (states[13] as num?)?.toDouble(),
      squawk: states[14] as String?,
      spi: states[15] as bool?,
      position_source: states[16] as int?,
      category: states.length > 17 ? states[17] as int? : null,
    );
  }
  
}

class MockPlaneApiService {
  final Map<String, dynamic> MockData = {
    "time": 1791910047,
    "states": [
      [
        "e8027e",
        "LPE2015 ",
        "Chile",
        1791910046,
        1791910046,
        -78.8373,
        -9.3875,
        10972.8,
        false,
        226.85,
        333.32,
        -0.33,
        null,
        11711.94,
        null,
        false,
        0
      ],
    ],
  };
}