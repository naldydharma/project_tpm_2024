import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  final List<String> favorites;
  final Function(List<String>) onUpdateFavorites; // Fungsi untuk memperbarui favorites

  const FavoritePage({Key? key, required this.favorites, required this.onUpdateFavorites}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<String> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    favoriteItems.addAll(widget.favorites); // Menambahkan favorites ke favoriteItems
  }

  void removeFromFavorites(String item) {
    setState(() {
      favoriteItems.remove(item);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Berhasil dihapus'),
        ),
      );
      widget.onUpdateFavorites(favoriteItems); // Memperbarui favorites
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        centerTitle: true,
      ),
      body: favoriteItems.isEmpty
          ? Center(child: Text('No favorite items yet'))
          : ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          final item = favoriteItems[index];
          return ListTile(
            title: Text(item),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                removeFromFavorites(item);
              },
            ),
          );
        },
      ),
    );
  }
}

