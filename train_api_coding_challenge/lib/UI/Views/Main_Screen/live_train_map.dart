import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_api_coding_challenge/UI/Core/Shared_Widgets/main_scaffold.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:train_api_coding_challenge/UI/Views/Main_Screen/view_models/live_train_map_view_model.dart';

class LiveTrainMap extends StatefulWidget {

  const LiveTrainMap({
    super.key
  });

  @override
  State<LiveTrainMap> createState() => _LiveTrainMapState();
}

class _LiveTrainMapState extends State<LiveTrainMap>{
  late final Completer<GoogleMapController> _controller;

  @override
  void initState(){
    super.initState();
    _controller = Completer<GoogleMapController>();
  }

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(51.5074, -0.1278),
    zoom: 10, 
  );

  @override
  Widget build(BuildContext context) {
     final vm = context.watch<LiveTrainmapViewModel>();
    return TrainAppScaffold(
      appTitle: "Train Live Map", 
      widgetBody: GoogleMap(
       mapType: MapType.hybrid,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        ),
    );
  }
}