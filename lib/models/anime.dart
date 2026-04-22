class Anime {
  final int id;
  final String title;
  final String imageUrl;

  Anime({required this.id, required this.title, required this.imageUrl});

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['mal_id'],
      title: json['title'] ?? 'Unknown Title',
      imageUrl: json['images']?['jpg']?['large_image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'mal_id': id,
    'title': title,
    'images': {'jpg': {'large_image_url': imageUrl}},
  };
}