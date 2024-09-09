import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:info_91_proj/core/widgets.dart/custom_common_appbar.dart';
import 'package:geolocator/geolocator.dart';
class LocationService {
  Future<Position> getCurrentLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, return an error
      return Future.error('Location services are disabled.');
    }

    // Check for location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, return an error
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, return an error
      return Future.error('Location permissions are permanently denied.');
    }

    // When permissions are granted, get the current position
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}

class MapSelectionScreen extends StatefulWidget {
  final     Position position;
   MapSelectionScreen({super.key, required this.position});

  @override
  State<MapSelectionScreen> createState() => _MapSelectionScreenState();
}

class _MapSelectionScreenState extends State<MapSelectionScreen> {
  late GoogleMapController mapController;
  

  LatLng selectedLocation = LatLng(0, 0);
  @override
  void initState() {
    selectedLocation=LatLng(widget.position.latitude,widget.position.longitude);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Column(children: [
          CustomAppBar(appBarName: "Send Location"),
          Expanded(child: GoogleMap(initialCameraPosition:  CameraPosition(
            target: LatLng(0, 0),
            zoom: 2,
          ),markers: {
                Marker(
              markerId: MarkerId('selected_location'),
              position: selectedLocation,
            ),
          },),)
        ],),
      ),
    );
  }
}