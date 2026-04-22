import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/anime_provider.dart';
import '../widgets/anime_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AnimeProvider>(context);
    final favs = provider.favorites;

    return Scaffold(
      appBar: AppBar(title: const Text('My Favorites'), backgroundColor: Colors.redAccent),
      body: favs.isEmpty
          ? const Center(child: Text("You haven't liked any anime yet."))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemCount: favs.length,
              itemBuilder: (c, i) => AnimeCard(anime: favs[i]),
            ),
    );
  }
}