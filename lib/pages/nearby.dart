import 'package:flutter/material.dart';
import 'package:project/services/firestore_service.dart';
import 'package:project/services/geolocator_service.dart';
import 'package:project/model/temple.dart';
import 'package:project/widgets/title_card.dart';
import 'package:geolocator/geolocator.dart';

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({Key? key}) : super(key: key);

  static String routeName = 'nearby';
  static Widget titleElement = const Text.rich(
    TextSpan(
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      children: [
        TextSpan(
          text: 'Temple Near Me',
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
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  final FirestoreService _firestoreService = FirestoreService.instance;

  @override
  void initState() {
    super.initState();
  }

@override
Widget build(BuildContext context) {
  return FutureBuilder<Position>(
    future: determinePosition(),
    builder: (context, positionSnapshot) {
      if (positionSnapshot.hasData) {
        Position position = positionSnapshot.data!;
        return _buildNearbyTempleStream(position);
      } else if (positionSnapshot.hasError) {
        return Center(child: Text('Error: ${positionSnapshot.error}'));
      }
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFFFDB741)),
      );
    },
  );
}

Widget _buildNearbyTempleStream(Position position) {
  return StreamBuilder<List<Temple>>(
    stream: _firestoreService.getNearbyTemple(
      position.latitude,
      position.longitude,
      radius: 30.0,
    ),
    builder: (ctx, nearbyTempleSnapshot) {
      if (nearbyTempleSnapshot.hasData) {
        List<Temple> temples = nearbyTempleSnapshot.data!;
        return temples.isNotEmpty
            ? _buildListView(temples)
            : _buildAllTempleStream();
      }
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFFFDB741)),
      );
    },
  );
}

Widget _buildAllTempleStream() {
  return StreamBuilder<List<Temple>>(
    stream: _firestoreService.getTemples(),
    builder: (ctx, allTempleSnapshot) {
      if (allTempleSnapshot.hasData) {
        List<Temple> temples = allTempleSnapshot.data!;
        return _buildListView(temples);
      }
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFFFDB741)),
      );
    },
  );
}

ListView _buildListView(List<Temple> items) {
  return ListView.builder(
    padding: const EdgeInsets.all(15),
    itemCount: items.length,
    itemBuilder: (context, index) {
      return titleCard(
        context,
        items[index].name['en']!,
        '/temple/${items[index].id}',
      );
    },
  );
}
}