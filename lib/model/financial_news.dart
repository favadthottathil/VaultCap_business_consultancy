

import 'package:vaultcap/utils/constant/sizedbox.dart';

class FinancialNews {
  FinancialNews({
    required this.author,
    required this.title,
    required this.description,
    required this.keywords,
    required this.snippet,
    required this.url,
    required this.imageUrl,
    required this.language,
    required this.publishedAt,
    required this.content,
  });
  late final String author;
  late final String title;
  late final String description;
  late final String keywords;
  late final String snippet;
  late final String url;
  late final String imageUrl;
  late final String language;
  late final String publishedAt;
  late final String content;

  FinancialNews.fromJson(Map<String, dynamic> json) {
    author = json['author'] ?? 'no auther';
    title = json['title'];
    description = json['description'] ?? '';
    // keywords = json['keywords'];
    // snippet = json['snippet'];
    url = json['url'];
    imageUrl = json['urlToImage'] ?? errorImage;
    // language = json['language'];
    publishedAt = json['publishedAt'];
    content = json['content'] ?? '';
  }
}
