import 'package:flutter/material.dart';
import 'package:project/model/province.dart';
import 'package:project/model/region.dart';
import 'package:project/widgets/appbar.dart';
import 'package:project/widgets/title_card.dart';

class ExploreProvinceScreen extends StatefulWidget {
  final Region region;
  const ExploreProvinceScreen({Key? key, required this.region})
      : super(key: key);

  static String routeName = 'explore_province';

  @override
  State<ExploreProvinceScreen> createState() => _ExploreProvinceScreenState();
}

class _ExploreProvinceScreenState extends State<ExploreProvinceScreen> {
  List<Province> _items = [];

  @override
  void initState() {
    super.initState();

    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        titleElement: Text(
          widget.region.name,
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
          Province prov = _items[index];

          return titleCard(
            context,
            _items[index].name,
            '/explore/${widget.region.slug}/${prov.slug}',
          );
        },
      ),
    );
  }

  Future<void> _loadItems() async {
    setState(() {
      _items = widget.region.provinces;
    });

    print('Loaded ${_items.length} items');
  }
}
