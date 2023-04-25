import 'package:flutter/material.dart';
import 'package:project/model/temple.dart';
import 'package:project/model/province.dart';
import 'package:project/services/firestore_service.dart';
import 'package:project/widgets/appbar.dart';
import 'package:project/widgets/title_card.dart';

class ExploreTempleScreen extends StatefulWidget {
  final Province province;
  const ExploreTempleScreen({Key? key, required this.province})
      : super(key: key);

  static String routeName = 'explore_temple';

  @override
  State<ExploreTempleScreen> createState() => _ExploreTempleScreenState();
}

class _ExploreTempleScreenState extends State<ExploreTempleScreen> {
  final FirestoreService _firestoreService = FirestoreService.instance;

  @override
  void initState() {
    super.initState();

    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Temple>>(
      stream:
          _firestoreService.getTemplesByProvinceSlug(widget.province.slug),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const CircularProgressIndicator(
            color: Color(0xFFFDB741),
          );
        }

        if (snapshot.hasData) {
          List<Temple> _items = snapshot.data!;
          return Scaffold(
            appBar: customAppBar(
              context: context,
              titleElement: Text(
                widget.province.name,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: ListView.builder(
              padding: const EdgeInsets.all(15.0),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                Temple hosp = _items[index];

                return titleCard(
                  context,
                  _items[index].name['en']!,
                  '/temple/${hosp.id}',
                );
              },
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xFFFDB741),
          ),
        );
      },
    );
  }

  Future<void> _loadItems() async {
    
  }
}
