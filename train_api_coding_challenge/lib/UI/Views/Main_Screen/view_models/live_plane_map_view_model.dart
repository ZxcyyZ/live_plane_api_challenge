
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_marker_widgets/google_maps_marker_widgets.dart';
import 'package:plane_api_coding_challenge/Data/Repositories/live_plane_repository.dart';

class LivePlanemapViewModel extends ChangeNotifier {
  final LivePlaneRepository _repository;

  // LatLngBounds(LatLng(50.041643719298904, -1.2996747717261314), LatLng(52.9274749588251, 1.0440760105848312))

 //comment
  LivePlanemapViewModel(
    this._repository,
  );

  List<PlaneStates> _planes = [];
  bool _isLoading = false;
  String? _error;

  List<PlaneStates> get planes => _planes;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadPlanes(LatLngBounds bounds, bool initialLoad) async {
    
    if(initialLoad){
      _isLoading = true;
    }
    _error = null;
    notifyListeners();

    try {
      final data = await _repository.fetchInitial(bounds);
      _planes = data.states;
    } catch (e) {
      _error = 'Could not load planes: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> buildMarkers(
    MarkerWidgetsController markerWidgetsController,
    Set<Marker> markers,
    LatLngBounds bounds,
  ) async {

    final currentIds = <MarkerId> {
      for(final plane in planes)
        if (plane.icao24 != null && plane.latitude != null && plane.longitude != null)
          MarkerId(plane.icao24!)
    };

    final notInBounds = markerWidgetsController.markerIds.where(
      (markerId) => !currentIds.contains(markerId)).toList();
    if(notInBounds.isNotEmpty) markerWidgetsController.bulkRemoveMarker(notInBounds);

    for(final plane in planes){
      if(plane.icao24 == null || plane.latitude == null || plane.longitude == null) continue;

      final Icon icon = Icon(Icons.flight, color: Colors.black, size: 30);
      final planeId = MarkerId(plane.icao24!);
      final existingPlane = markerWidgetsController.markerForId(planeId);

      if(existingPlane != null) {
        markerWidgetsController.updateMarker(
          existingPlane.copyWith(
            positionParam: LatLng(plane.latitude!, plane.longitude!),
            rotationParam: plane.true_track ?? 0,
          ),
          animated: false,
        );
      } else{
        markerWidgetsController.addMarkerWidget(
          markerWidget: MarkerWidget(
            markerId: planeId,
            child: icon,
          ), 
          marker: Marker(
            markerId: planeId,
            position: LatLng(plane.latitude!, plane.longitude!),
            rotation: plane.true_track ?? 0
            )
          );
      }
    }
   
  }

  Future<void> removeMarkers(
    MarkerWidgetsController markerWidgetsController,
    Set<Marker> markers,
    LatLngBounds bounds,
  ) async {
    if (markers.isEmpty) return;
    markerWidgetsController.bulkRemoveMarker(markerWidgetsController.markerIds);
    // for(final marker in markers){
    //   if(!bounds.contains(marker.position)){
    //     print("Removing marker");
    //     markerWidgetsController.removeMarker(marker.markerId);
    //   }
  }
}
