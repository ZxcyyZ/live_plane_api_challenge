import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plane_api_coding_challenge/UI/Core/Shared_Widgets/main_scaffold.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_marker_widgets/google_maps_marker_widgets.dart';
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
  final MarkerWidgetsController _markerWidgetsController = MarkerWidgetsController();
  bool _loadingMap = false;
  LatLngBounds? _cachedBounds;

  @override
  void initState(){
    super.initState();
    setState(() {
      _loadingMap = true;
    });

    _controller = Completer<GoogleMapController>();
  }

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(51.5074, -0.1278),
    zoom: 6, 
  );

  @override
  Widget build(BuildContext context) {
    final LivePlanemapViewModel vm = context.watch<LivePlanemapViewModel>();
    return PlaneAppScaffold(
      appTitle: "Plane Live Map", 
      widgetBody:  Stack(
        children: [
           if (_loadingMap)
            _loadingWidget("Loading Map"),
         _markers(vm),
          if(vm.isLoading && !_loadingMap)
            _loadingWidget("Loading Planes in bounds"),
          if(vm.error != null)
            SnackBar(content: Text(vm.error!))

        ],
      )
    );
  }
  

  // vm.isLoading 
  //       ? _loadingWidget() 
  //       : vm.error != null
  //         ? Center(child: Text(vm.error!))
  //         :

  Widget _loadingWidget(String message) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.withAlpha(50)
      ),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.red),
            SizedBox(height: 10),
            Text(message),
          ],
        ),
      ],
    ),
    );
  }
  Widget _markers(LivePlanemapViewModel vm) {
    return MarkerWidgets(
      markerWidgetsController: _markerWidgetsController, 
      builder: (context, markers) => _googleMaps(vm, markers)
    );
  }

  Widget _googleMaps (LivePlanemapViewModel vm, Set<Marker> markers) {
    return GoogleMap(
       mapType: MapType.normal,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (GoogleMapController controller) async{
          setState(() {
            _loadingMap = false;
          });
          _controller.complete(controller);
        },
        onCameraIdle: () async {
          print("Camera idle");
          final controller = await _controller.future;
          final bounds = await controller.getVisibleRegion();
          if(_cachedBounds == bounds) return;
          _cachedBounds = bounds;
          await vm.loadPlanes(bounds, false);
          
          vm.buildMarkers(_markerWidgetsController);
        },
        markers: markers,
      );
  }
}