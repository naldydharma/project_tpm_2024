import 'package:flutter/material.dart';

class MyFormPage extends StatefulWidget {
  const MyFormPage({Key? key}) : super(key: key);

  @override
  _MyFormPageState createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  TextEditingController _controller = TextEditingController();
  String _message = '';

  void _submitMessage() {
    setState(() {
      _message = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
            _message.isEmpty
                ? Container()
                : Text(
              'Your message: $_message',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}