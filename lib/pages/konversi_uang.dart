import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class konversiUang extends StatefulWidget {
  const konversiUang({Key? key}) : super(key: key);

  @override
  _konversiUangState createState() => _konversiUangState();
}

class _konversiUangState extends State<konversiUang> {
  TextEditingController _controller = TextEditingController();
  double idrAmount = 0;
  double usdAmount = 0;
  double jpyAmount = 0;
  double krwAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Money Converter',
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
              'IDR to USD, JPY, and KRW Converter',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: InputDecoration(
                labelText: 'Enter amount in IDR',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty || double.tryParse(value) == null) {
                    idrAmount = 0;
                  } else {
                    idrAmount = double.parse(value);
                  }
                  usdAmount = idrAmount * 0.000069; // 1 IDR = 0.000069 USD
                  jpyAmount = idrAmount * 0.0076; // 1 IDR = 0.0076 JPY
                  krwAmount = idrAmount * 0.082; // 1 IDR = 0.082 KRW
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Equivalent in USD: \$${usdAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Equivalent in JPY: ¥${jpyAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Equivalent in KRW: ₩${krwAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
