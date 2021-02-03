import 'dart:async';

import '../models/most_popular_articles.dart';
import '../../../util/http_helper.dart';

class MostPopularRepository {
  final String _apiKey = "a7ZXLGYIBm0waznFMAOTQ6G7jhpk7EgM";
  final httpHelper = HttpHelper();

  Future<MostPopularArticles> getMostPopularArticles() async {
    try {
      final articlesJson = await httpHelper.get(
          "mostpopular/v2/mostviewed/all-sections/7.json?api-key=" + _apiKey);
      return MostPopularArticles.fromJson(articlesJson);
    } on Exception {
      return null;
    }
  }
}
