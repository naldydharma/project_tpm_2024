import 'package:flutter/material.dart';
import 'package:project_tpm1/pages/detail_page.dart';
import 'package:project_tpm1/pages/favorite_page.dart';
import 'package:project_tpm1/pages/profile_page.dart';
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
  final TextEditingController _searchController = TextEditingController();
  List<mmoGamesList> _filteredGames = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    _searchController.addListener(_filterGames);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterGames);
    _searchController.dispose();
    super.dispose();
  }

  void addToFavorites(String title) {
    setState(() {
      if (!favorites.contains(title)) {
        favorites.add(title);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Game ditambahkan menjadi favorite'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Game sudah ada di halaman favorite'),
          ),
        );
      }
    });
  }

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('https://www.mmobomb.com/api1/games?platform=pc'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        game = responseData.map((json) => mmoGamesList.fromJson(json)).toList();
        _filteredGames = game!;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  String truncateDescription(String description) {
    List<String> words = description.split(' ');
    if (words.length > 20) {
      return words.take(20).join(' ') + '...';
    } else {
      return description;
    }
  }

  void _filterGames() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredGames = game!;
      } else {
        _filteredGames = game!.where((g) => g.title!.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
      }
    });
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
          Theme(
            data: Theme.of(context).copyWith(
              popupMenuTheme: PopupMenuThemeData(
                color: Colors.white,
                textStyle: TextStyle(color: Colors.black),
              ),
            ),
            child: PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'FavoritePage',
                  child: Text('Favorite Page'),
                ),
              ],
              onSelected: (String value) async {
                if (value == 'FavoritePage') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoritePage(
                        favorites: favorites,
                        onUpdateFavorites: (updatedFavorites) {
                          setState(() {
                            favorites = updatedFavorites;
                          });
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ),
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
            SizedBox(height: 8),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _filterGames();
                    });
                  },
                )
                    : null,
                filled: true,
                fillColor: Colors.redAccent[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredGames.length,
                itemBuilder: (context, index) {
                  final data = _filteredGames[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    elevation: 5,
                    child: ListTile(
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
                        icon: Icon(
                          favorites.contains(data.title) ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          addToFavorites(data.title ?? '');
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
                    ),
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
