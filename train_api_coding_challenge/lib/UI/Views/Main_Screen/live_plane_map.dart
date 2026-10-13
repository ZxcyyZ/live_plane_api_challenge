import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plane_api_coding_challenge/UI/Core/Shared_Widgets/main_scaffold.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plane_api_coding_challenge/UI/Views/Main_Screen/view_models/live_plane_map_view_model.dart';

class LivePlaneMap extends StatefulWidget {

  const LivePlaneMap({
    super.key
  });

  @override
  State<LivePlaneMap> createState() => _LivePlaneMapState();
}

class _LivePlaneMapState extends State<LivePlaneMap>{
  late final Completer<GoogleMapController> _controller;

  @override
  void initState(){
    super.initState();
    _controller = Completer<GoogleMapController>();
  }

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(51.5074, -0.1278),
    zoom: 16, 
  );

  @override
  Widget build(BuildContext context) {
     final vm = context.watch<LivePlanemapViewModel>();
    return PlaneAppScaffold(
      appTitle: "Plane Live Map", 
      widgetBody: GoogleMap(
       mapType: MapType.normal,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        ),
    );
  }
}