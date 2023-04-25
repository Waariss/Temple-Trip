import 'package:flutter/material.dart';
import 'package:project/pages/explore_region.dart';
import 'package:project/pages/map.dart';
import 'package:project/pages/nearby.dart';
import 'package:project/pages/aboutus.dart';
import 'package:project/widgets/appbar.dart';
class HomeScreen extends StatefulWidget {
  final int selectedIndex;
  const HomeScreen({Key? key, this.selectedIndex = 0}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Index of the selected tab
  // List of widgets tab
  final List<Widget> tabs = const [
    NearbyScreen(),
    ExploreRegionScreen(),
    MapView(),
    AboutUsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        titleElement: _getTitleElement(_selectedIndex),
      ),
      backgroundColor: Colors.white,
      body: tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.near_me_rounded),
            label: 'Nearby',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_rounded),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_rounded),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_rounded),
            label: 'About us',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 10.0,
        selectedItemColor: const Color(0xFFFDB741),
        unselectedItemColor: const Color(0xFF828282),
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
      ),
    );
  }

  Widget? _getTitleElement(int index) {
    if (index == 0) {
      return NearbyScreen.titleElement;
    }

    if (index == 1) {
      return ExploreRegionScreen.titleElement;
    }

    if (index == 2) {
      return MapView.titleElement;
    }

    if (index == 3){
      return AboutUsScreen.titleElement;
    }

    return Text.rich(
      TextSpan(
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        children: [
          const TextSpan(
            text: 'Temple_Trip',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Container(
              margin: const EdgeInsets.only(left: 5.0)
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
