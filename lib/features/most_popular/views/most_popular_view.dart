import 'package:flutter/material.dart';
import '../models/most_popular_articles.dart';
import '../models/most_popular_details.dart';
import '../blocs/most_popular_bloc.dart';
import '../views/detail_view.dart';

class MostPopularView extends StatefulWidget {
  @override
  _MostPopularViewState createState() => _MostPopularViewState();
}

class _MostPopularViewState extends State<MostPopularView> {
  @override
  void initState() {
    super.initState();
    mostPopularBloc.fetchMostPopularArticles();
  }

  @override
  void dispose() {
    mostPopularBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "NY Times Most Popular",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () => {}),
        ],
        leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.black), onPressed: () => {}),
      ),
      body: StreamBuilder(
        stream: mostPopularBloc.mostPopularArticles,
        builder: (context, AsyncSnapshot<MostPopularArticles> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<MostPopularArticles> snapshot) {
    List<Result> results = snapshot.data.results;
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey,
        indent: 70,
        endIndent: 50,
      ),
      itemCount: results.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () => openDetailPage(results[index]),
          contentPadding: EdgeInsets.all(10),
          title: Text(results[index].title),
          leading: Container(
            width: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        results[index].media[0]?.mediaMetadata[0]?.url))),
          ),
          trailing:
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: 30,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () => openDetailPage(results[index]),
                )),
          ]),
          subtitle: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(
                  results[index].byline,
                  overflow: TextOverflow.ellipsis,
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.date_range,
                      color: Colors.grey,
                      size: 20,
                    ),
                    Text(results[index]
                        .publishedDate
                        .toString()
                        .substring(0, 10))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  openDetailPage(Result data) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailView(
          details: MostPopularDetails(
        title: data.title,
        imageUrl: data.media[0]?.mediaMetadata[0]?.url,
        articleAbstract: data.resultAbstract,
        authors: data.byline,
        publishedDate: data.publishedDate,
      ));
    }));
  }
}
