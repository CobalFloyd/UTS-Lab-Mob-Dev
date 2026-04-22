import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/anime_provider.dart';
import '../widgets/anime_card.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AnimeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: const Text('Anime Center', style: TextStyle(color: Colors.white)),
        actions: [
          DropdownButton<int>(
            value: provider.currentYear,
            dropdownColor: Colors.blueGrey[800],
            style: const TextStyle(color: Colors.white),
            underline: Container(),
            items: [2024, 2025, 2026].map((y) => DropdownMenuItem(value: y, child: Text(y.toString()))).toList(),
            onChanged: (val) => provider.loadData(val!, provider.currentSeason),
          ),
          DropdownButton<String>(
            value: provider.currentSeason,
            dropdownColor: Colors.blueGrey[800],
            style: const TextStyle(color: Colors.white),
            underline: Container(),
            items: ['spring', 'summer', 'fall', 'winter'].map((s) => DropdownMenuItem(value: s, child: Text(s.toUpperCase()))).toList(),
            onChanged: (val) => provider.loadData(provider.currentYear, val!),
          ),
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.redAccent),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const FavoritesScreen())),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search anime...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
              onChanged: (val) => provider.searchAnime(val),
            ),
          ),
        ),
      ),
      body: _buildBody(provider),
    );
  }

  Widget _buildBody(AnimeProvider provider) {
    if (provider.isLoading) return const Center(child: CircularProgressIndicator());
    if (provider.errorMessage != null) return Center(child: Text(provider.errorMessage!));

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, mainAxisSpacing: 10, crossAxisSpacing: 10),
      itemCount: provider.animeList.length,
      itemBuilder: (c, i) => AnimeCard(anime: provider.animeList[i]),
    );
  }
}