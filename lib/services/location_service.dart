import 'package:location/location.dart';
import '../models/location_model.dart';
import 'package:geocoding/geocoding.dart' as gecoding;

class LocationService {
  Location location = Location();
  List<gecoding.Placemark>? placemarks;
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  MyLocationData? myLocationData;

  Future<void> gettingLocation() async {
    _serviceEnabled = await location.serviceEnabled();

    if (_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    placemarks = await gecoding.placemarkFromCoordinates(
        _locationData!.latitude!, _locationData!.longitude!);
  }
}
