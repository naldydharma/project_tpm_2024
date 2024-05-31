import 'package:flutter/material.dart';
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
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    game.thumbnail ?? '',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
            child: Text(
              game.title ?? '',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow("Description", '${game.shortDescription ?? ''}'),
            SizedBox(height: 10),
              _buildDetailRow("Genre", '${game.genre ?? ''}'),
            SizedBox(height: 10),
              _buildDetailRow("Platform", '${game.platform ?? ''}'),
              SizedBox(height: 10),
              _buildDetailRow("Publisher", '${game.publisher ?? ''}'),
              SizedBox(height: 10),
              _buildDetailRow("Developer", '${game.developer ?? ''}'),
              SizedBox(height: 10),
              _buildDetailRow("Release Date", '${game.releaseDate ?? ''}'),
                    ],
                  ),
                ),
               ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDetailRow(String title, String detail) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 255, 0, 0),
        ),
      ),
      SizedBox(height: 8),
      Text(
        detail,
        style: TextStyle(fontSize: 16),
      ),
    ],
  );
}

