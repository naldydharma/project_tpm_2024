import 'package:flutter/material.dart';
import 'package:project_tpm1/pages/profile_page.dart';
import 'package:project_tpm1/pages/konversi_uang.dart';
import 'package:project_tpm1/pages/konversi_waktu.dart';
import './list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    ListPage(),
    KonversiUang(),
    TimeConverterPage(),
    ProfilePage(), // Tambahkan widget halaman profil di sini
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return ListPage();
      case 1:
        return KonversiUang();
      case 2:
        return TimeConverterPage();
      case 3:
        return ProfilePage();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 255, 0, 0),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on, size: 30),
            label: 'Currency',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time, size: 30),
            label: 'Time',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, size: 30),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
