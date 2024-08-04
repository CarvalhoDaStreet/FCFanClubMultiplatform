import 'package:fc_fan_club/features/fanspace/presentation/pages/fan_space_page.dart';
import 'package:fc_fan_club/features/gallery/presentation/pages/galleries_page.dart';
import 'package:flutter/material.dart';
import 'package:fc_fan_club/features/news/presentation/pages/news_page.dart';
import 'package:fc_fan_club/features/fixtures/presentation/pages/fixtures_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    NewsPage(),
    FixturesPage(),
    GalleriesPage(),
    FanSpacePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: 'Fixtures',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Galleries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Fan Space',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
