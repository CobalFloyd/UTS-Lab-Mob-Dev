import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/anime.dart';
import '../providers/anime_provider.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;
  const AnimeCard({required this.anime, super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AnimeProvider>(context);
    final isFav = provider.isFavorite(anime.id);

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.network(
                  anime.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => const Icon(Icons.broken_image),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(anime.title, maxLines: 2, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
          Positioned(
            top: 5, right: 5,
            child: IconButton(
              icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
              color: isFav ? Colors.red : Colors.white,
              onPressed: () => provider.toggleFavorite(anime),
            ),
          ),
        ],
      ),
    );
  }
}