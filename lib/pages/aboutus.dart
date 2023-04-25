import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);
  static String routeName = 'about';
  static Widget titleElement = const Text.rich(
    TextSpan(
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      children: [
        TextSpan(
          text: 'About us',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    textAlign: TextAlign.center,
  );

  Widget _buildProfileImage(String assetPath) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFFDB741), width: 2.0),
      ),
      child: ClipOval(
        child: Image.asset(
          assetPath,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: _buildProfileImage('assets/images/M-Profile.jpeg'),
            title: const Text(
              'Mr. Waris Damkahm',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            subtitle: const Text(
              '6388014, Mahidol University',
            ),
          ),
          const Divider(),
          ListTile(
            leading: _buildProfileImage('assets/images/H-Profile.jpg'),
            title: const Text(
              'Mr. Chatkawin Phongpawarit',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            subtitle: const Text(
              '6388041, Mahidol University',
            ),
          ),
          const Divider(),
          ListTile(
            leading: _buildProfileImage('assets/images/Fifa-Profile.jpg'),
            title: const Text(
              'Miss Chanisara Kotrachai',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            subtitle: const Text(
              '6388087, Mahidol University',
            ),
          ),
        ],
      ),
    );
  }
}
