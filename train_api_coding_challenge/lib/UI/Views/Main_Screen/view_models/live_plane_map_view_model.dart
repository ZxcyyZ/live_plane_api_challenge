
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

  Future<void> buildMarkers(MarkerWidgetsController markerWidgetsController) async{
    for(final plane in planes){
      if(plane.latitude != null && plane.longitude != null){
        markerWidgetsController.addMarkerWidget(
          markerWidget: MarkerWidget(
            markerId: MarkerId(plane.icao24 ?? ''),
            child: Icon(Icons.flight, color: Colors.black, size: 25,),
          ), 
          marker: Marker(
            markerId: MarkerId(plane.icao24 ?? ''),
            position: LatLng(plane.latitude!, plane.longitude!),
            rotation: plane.true_track!
            )
          );
      }
    }
  }
}