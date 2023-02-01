// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, unused_field, prefer_final_fields
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:udemy_course/shared/styles/icon_broken.dart';
import '../../../layout/social_app/cubit/social_cubit.dart';
import '../../../layout/social_app/cubit/social_states.dart';

class MapsScreen extends StatefulWidget {
  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

Position? position;

class _MapsScreenState extends State<MapsScreen> {
  Completer<GoogleMapController> _mapController = Completer();

 

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
  }

  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    tilt: 0,
    target: LatLng(position!.latitude, position!.longitude),
    zoom: 17,
  );

 

  Widget buildMap() => GoogleMap(
        myLocationEnabled: true,
        mapType: MapType.normal,
        markers: const {},
        myLocationButtonEnabled: false,
        initialCameraPosition: _myCurrentLocationCameraPosition,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              position != null
                  ? buildMap()
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ],
          ),
          floatingActionButton: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 8, 32),
            child: FloatingActionButton.extended(
              onPressed: _goToMyCurrentLocation,
              label: Text("me"),
              icon: const Icon(IconBroken.Location),
            ),
          ),
        );
      },
    );
  }
}
