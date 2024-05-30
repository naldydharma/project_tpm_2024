import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/http_model.dart';

class DetailPage extends StatelessWidget {
  final mmoGamesList game;

  const DetailPage({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Game',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.center,
                child: Image.network(
                  game.thumbnail ?? '',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              game.title ?? '',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '${game.shortDescription ?? ''}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Genre: ${game.genre ?? ''}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Platform: ${game.platform ?? ''}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Publisher: ${game.publisher ?? ''}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Developer: ${game.developer ?? ''}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Release Date: ${game.releaseDate ?? ''}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

