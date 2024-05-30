import 'package:flutter/material.dart';
import 'package:project_tpm1/pages/detail_page.dart';
import 'package:project_tpm1/pages/favorite_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'package:http/http.dart' as http;
import '../model/http_model.dart';
import 'dart:convert';

class ListPage extends StatefulWidget {
  const ListPage({Key? key});

  @override
  State<ListPage> createState() => _ListPageState();
}
class _ListPageState extends State<ListPage> {
  List<mmoGamesList>? game = [];
  List<String> favorites = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Metode untuk menambahkan item ke daftar favorit
  void addToFavorites(String title) {
    setState(() {
      favorites.add(title);
    });
  }

  // Metode untuk mengambil data game dari API
  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('https://www.mmobomb.com/api1/games?platform=pc'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        game = responseData.map((json) => mmoGamesList.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Metode untuk memotong deskripsi menjadi 20 kata
  String truncateDescription(String description) {
    List<String> words = description.split(' ');
    if (words.length > 20) {
      return words.take(20).join(' ') + '...';
    } else {
      return description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritePage(favorites: favorites)),
              );
            },
            icon: Icon(Icons.favorite, color: Colors.white),
          ),
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('login', true);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: Icon(Icons.logout, color: Colors.white),
          )
        ],
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "MMO Games List",
              style: TextStyle(fontSize: 30),
            ),

            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: game?.length ?? 0,
                itemBuilder: (context, index) {
                  final data = game![index];
                  return ListTile(
                    leading: Image.network(
                      data.thumbnail ?? '',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      data.title ?? '',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      truncateDescription(data.shortDescription ?? ''),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {
                        addToFavorites(data.title ?? ''); // Panggil metode addToFavorites
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Game ditambahkan ke favorit'),
                          ),
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(game: data),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
