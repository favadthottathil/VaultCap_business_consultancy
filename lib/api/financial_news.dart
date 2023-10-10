import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:taxverse/model/financial_news.dart';

class FinancialNewsService {
  // final apiEndPoints = 'https://api.marketaux.com/v1/news/all?countries=in&filter_entities=true&limit=10&published_after=2023-09-29T14:10&api_token=vIfQtWxgdcpiWdKUKGaD08JLjskH0eXuimKwAA0p';
  final apiEndPoints = 'https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=1db2c92630fb48ea8d6b6f5a5b13ccfa';

  int currentpage = 1;

  Future<List<FinancialNews>> fetchFinancialNews(int page) async {
    final url = Uri.parse('$apiEndPoints&page=$page&pageSize=8');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        List<dynamic> newsList = json['articles'];

        List<FinancialNews> newsData =
            newsList.map((item) => FinancialNews.fromJson(item)).toList();

        return newsData;
      } else {
        throw Exception("Can't get financial news");
      }
    } catch (error) {
      throw Exception("Error fetching financial news: $error");
    }
  }
}
