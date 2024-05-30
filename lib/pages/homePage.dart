import 'package:flutter/material.dart';
import 'package:project_tpm1/pages/konversi_uang.dart';
import 'package:project_tpm1/pages/konversi_waktu.dart';
import 'package:project_tpm1/pages/message_page.dart';
import './profile_page.dart';
import './list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget> [
    ListPage(),
    konversiUang(),
    TimeConverterPage(),
    MyFormPage()
    // ProfilePage(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Homepage'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_outlined),
              label: 'Currency'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.lock_clock),
              label: 'Time'
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}
