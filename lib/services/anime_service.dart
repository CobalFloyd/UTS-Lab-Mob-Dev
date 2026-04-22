import 'package:dio/dio.dart';
import '../models/anime.dart';

class AnimeService {
  final Dio _dio = Dio();

  Future<List<Anime>> fetchAnime(int year, String season) async {
    try {
      final response = await _dio.get('https://api.jikan.moe/v4/seasons/$year/$season');
      final List rawData = response.data['data'];
      
      // Filter unique IDs to prevent "doubles" in the grid
      final Map<int, Anime> uniqueMap = {};
      for (var item in rawData) {
        final anime = Anime.fromJson(item);
        if (!uniqueMap.containsKey(anime.id)) {
          uniqueMap[anime.id] = anime;
        }
      }
      return uniqueMap.values.toList();
    } catch (e) {
      throw "Check your connection and try again!";
    }
  }

  Future<List<Anime>> fetchTopAnime() async {
    final response = await _dio.get('https://api.jikan.moe/v4/top/anime');
    final List rawData = response.data['data'];
    return rawData.map((e) => Anime.fromJson(e)).toList();
  }
}