import 'package:flutter/material.dart';
import 'trainings_page.dart';
import 'profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [TrainingsPage(), ProfilePage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        height: 100,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.list_alt,
                size: 32,
                color: _selectedIndex == 0
                    ? Color.fromRGBO(57, 129, 224, 1)
                    : Colors.black,
              ),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                size: 32,
                color: _selectedIndex == 1
                    ? Color.fromRGBO(57, 129, 224, 1)
                    : Colors.black,
              ),
              onPressed: () => _onItemTapped(1),
            ),
          ],
        ),
      ),
    );
  }
}
