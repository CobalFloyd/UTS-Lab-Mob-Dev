import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/anime.dart';
import '../services/anime_service.dart';

class AnimeProvider with ChangeNotifier {
  List<Anime> _allAnime = [];
  List<Anime> _filteredAnime = [];
  List<Anime> _favoriteAnime = [];
  
  bool isLoading = false;
  String? errorMessage;
  int currentYear = 2024;
  String currentSeason = 'spring';

  List<Anime> get animeList => _filteredAnime;
  List<Anime> get favorites => _favoriteAnime;

  AnimeProvider() {
    _loadFavorites();
    loadData(2024, 'spring');
  }

  Future<void> loadData(int year, String season) async {
    isLoading = true;
    errorMessage = null;
    currentYear = year;
    currentSeason = season;
    notifyListeners();

    try {
      _allAnime = await AnimeService().fetchAnime(year, season);
      _filteredAnime = _allAnime;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void searchAnime(String query) {
    _filteredAnime = _allAnime
        .where((a) => a.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void toggleFavorite(Anime anime) async {
    final index = _favoriteAnime.indexWhere((e) => e.id == anime.id);
    if (index >= 0) {
      _favoriteAnime.removeAt(index);
    } else {
      _favoriteAnime.add(anime);
    }
    _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(int id) => _favoriteAnime.any((e) => e.id == id);

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _favoriteAnime.map((e) => e.toJson()).toList();
    await prefs.setString('global_favs', json.encode(data));
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? saved = prefs.getString('global_favs');
    if (saved != null) {
      final List decoded = json.decode(saved);
      _favoriteAnime = decoded.map((e) => Anime.fromJson(e)).toList();
      notifyListeners();
    }
  }
}