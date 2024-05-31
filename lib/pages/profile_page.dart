import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _controller = TextEditingController();
  List<String> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  // Method to load messages from SharedPreferences
  Future<void> _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _messages = prefs.getStringList('messages') ?? [];
    });
  }

  // Method to save messages to SharedPreferences
  Future<void> _saveMessages(List<String> messages) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('messages', messages);
  }

  // Method to remove message from SharedPreferences
  Future<void> _removeMessage(int index) async {
    setState(() {
      _messages.removeAt(index);
      _saveMessages(_messages); // Save updated messages to SharedPreferences
    });
  }

  void _submitMessage() {
    setState(() {
      String message = _controller.text;
      _messages.add(message);
      _saveMessages(_messages); // Save messages to SharedPreferences
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Page',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            SizedBox(height: 20.0),

            Text(
              'Muhammad Rainaldy Dharmawan',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              '123456789',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'TPM IF-E',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter your message',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitMessage,
              child: Text('Submit'),
            ),
            SizedBox(height: 20),
            _messages.isNotEmpty
                ? ListView.builder(
              shrinkWrap: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                String message = _messages[index];
                return ListTile(
                  title: Text(
                    message,
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _removeMessage(index);
                    },
                  ),
                );
              },
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
