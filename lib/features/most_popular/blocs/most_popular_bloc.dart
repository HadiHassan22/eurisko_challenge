import 'package:rxdart/rxdart.dart';
import '../repositories/most_popular_repository.dart';
import '../models/most_popular_articles.dart';

class MostPopularBloc {
  final _repository = MostPopularRepository();
  final _articlesFetcher = PublishSubject<MostPopularArticles>();

  Stream<MostPopularArticles> get mostPopularArticles =>
      _articlesFetcher.stream;

  fetchMostPopularArticles() async {
    MostPopularArticles articles = await _repository.getMostPopularArticles();
    _articlesFetcher.sink.add(articles);
  }

  dispose() {
    _articlesFetcher.close();
  }
}

final mostPopularBloc = MostPopularBloc();
