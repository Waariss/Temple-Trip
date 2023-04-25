import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:project/model/temple.dart';
import 'package:project/services/firestore_service.dart';
import 'package:project/services/geolocator_service.dart';

class TempleDetailScreen extends StatefulWidget {
  final String hId;
  const TempleDetailScreen({Key? key, required this.hId}) : super(key: key);

  @override
  State<TempleDetailScreen> createState() => _TempleDetailScreenState();
}

class _TempleDetailScreenState extends State<TempleDetailScreen> {
  final FirestoreService _firestoreService = FirestoreService.instance;
  Position? _myLocation;

  @override
  void initState() {
    super.initState();
    _getMyLocation();
  }
  
  @override
Widget build(BuildContext context) {
  return StreamBuilder<Temple>(
    stream: _firestoreService.getTempleById(widget.hId),
    builder: (context, snapshot) {
      if (snapshot.hasError || !snapshot.hasData) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xFFFDB741),
          ),
        );
      }

      Temple temple = snapshot.data!;
      double distance = _getDistance(
        _myLocation?.latitude ?? 0,
        _myLocation?.longitude ?? 0,
        temple.geolocation.latitude,
        temple.geolocation.longitude,
      );
      String distanceText = _convertDistanceMeterToKm(distance);

      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Temple Details',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFFFDB741),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 200,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      temple.geolocation.latitude + 0.002,
                      temple.geolocation.longitude,
                    ),
                    zoom: 15.0,
                  ),
                  myLocationButtonEnabled: false,
                  myLocationEnabled: false,
                  markers: {
                    Marker(
                      markerId: MarkerId(temple.id.toString()),
                      position: LatLng(
                        temple.geolocation.latitude,
                        temple.geolocation.longitude,
                      ),
                      infoWindow: InfoWindow(
                        title: temple.name['en']!,
                        snippet: temple.region['en']!,
                      ),
                      icon: BitmapDescriptor.defaultMarker,
                    ),
                  },
                ),
              ),
              const SizedBox(height: 24),
              Text(
                temple.name['en']!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                temple.address['en']!,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_myLocation != null)
                    Text(
                      'Distance: $distanceText',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ElevatedButton.icon(
                    onPressed: () {
                      launch(
                        'https://www.google.com/maps/dir/?api=1&destination=${Uri.encodeComponent(temple.address['en']!)}&destination_place_id=${Uri.encodeComponent(temple.googleMapsPlaceId)}',
                      );
                    },
                    icon: const Icon(Icons.map_outlined),
                    label: const Text('Navigate'),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFFDB741),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}


  Future<void> _getMyLocation() async {
    final location = await determinePosition();
    setState(() {
      _myLocation = location;
    });
  }

  double _getDistance(
      double latStart, double lngStart, double latStop, double lngStop) {
    return Geolocator.distanceBetween(latStart, lngStart, latStop, lngStop);
  }

  String _convertDistanceMeterToKm(double distance) {
    double distanceKm = distance / 1000;

    if (distanceKm > 1) {
      return '${distanceKm.toStringAsFixed(2)} km';
    } else {
      return '${distance.toStringAsFixed(2)} m';
    }
  }
}
