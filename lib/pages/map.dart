import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/model/temple.dart';
import 'package:project/services/firestore_service.dart';
import 'package:project/services/geolocator_service.dart';
import 'package:project/widgets/title_card.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);
  static Widget titleElement = const Text.rich(
    TextSpan(
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      children: [
        TextSpan(
          text: 'Map',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    textAlign: TextAlign.center,
  );

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final FirestoreService _firestoreService = FirestoreService.instance;
  final Completer<GoogleMapController> _controller = Completer();
  final Map<String, Marker> _markers = {};

  Temple? _selectedTemple;

  @override
  void initState() {
    super.initState();
  }
@override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
      future: determinePosition(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Position position = snapshot.data!;
          return Stack(
            children: [
              Positioned.fill(
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 13.0,
                  ),
                  onMapCreated: _onMapCreated,
                  onCameraMove: (position) {
                    _queryNearbyTemple(
                      position.target.latitude,
                      position.target.longitude,
                    );
                  },
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  markers: _markers.values.toSet(),
                ),
              ),
              _selectedTemple != null
                  ? Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: titleCard(
                            context,
                            _selectedTemple!.name['en']!,
                            '/temple/${_selectedTemple!.id}',
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Center(
            child: CircularProgressIndicator(
          color: Color(0xFF8CCF75),
        ));
      },
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    Position myPosition = await determinePosition();
    _queryNearbyTemple(myPosition.latitude, myPosition.longitude);
  }

  Future<void> _queryNearbyTemple(double latitude, double longitude) async {
    _firestoreService
        .getNearbyTemple(
      latitude,
      longitude,
      radius: 5.0,
    )
        .listen(
      (temples) {
        _updateMarkers(temples);
      },
    );
  }

  void _updateMarkers(List<Temple> temples) async {
    setState(() {
      _markers.clear();
      for (final temple in temples) {
        final marker = _createTempleMarker(temple);
        _markers[temple.id] = marker;
      }
    });
  }

  Marker _createTempleMarker(Temple temple) {
    return Marker(
      markerId: MarkerId(temple.name['en']!),
      position:
          LatLng(temple.geolocation.latitude, temple.geolocation.longitude),
      onTap: () {
        setState(() {
          _selectedTemple = temple;
        });
      },
    );
  }
}
