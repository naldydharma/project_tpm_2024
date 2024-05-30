import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class TimeConverterPage extends StatefulWidget {
  const TimeConverterPage({Key? key}) : super(key: key);

  @override
  _TimeConverterPageState createState() => _TimeConverterPageState();
}

class _TimeConverterPageState extends State<TimeConverterPage> {
  TextEditingController _controller = TextEditingController();
  String wibTime = '';
  String witaTime = '';
  String witTime = '';
  String londonTime = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Time Converter',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('login', true);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
            icon: Icon(Icons.logout, color: Colors.white,),
          )
        ],
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'WIB, WITA, WIT, and London Time Converter',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                labelText: 'Enter time (format: HH:mm)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    wibTime = '';
                    witaTime = '';
                    witTime = '';
                    londonTime = '';
                  } else {
                    try {
                      var time = DateTime.parse('2022-01-01 ' + value);
                      wibTime = time.toString();
                      witaTime = (time.toUtc().add(Duration(hours: 1))).toString();
                      witTime = (time.toUtc().add(Duration(hours: 2))).toString();
                      londonTime = (time.toUtc().add(Duration(hours: 7))).toString();
                    } catch (e) {
                      wibTime = '';
                      witaTime = '';
                      witTime = '';
                      londonTime = '';
                    }
                  }
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'WIB Time: $wibTime',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'WITA Time: $witaTime',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'WIT Time: $witTime',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'London Time: $londonTime',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TimeConverterPage(),
  ));
}
