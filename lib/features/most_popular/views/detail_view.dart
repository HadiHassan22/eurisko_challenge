import 'package:flutter/material.dart';
import '../models/most_popular_details.dart';

class DetailView extends StatefulWidget {
  final MostPopularDetails details;

  DetailView({@required this.details});

  @override
  _DetailViewState createState() => _DetailViewState(details: details);
}

class _DetailViewState extends State<DetailView> {
  final MostPopularDetails details;

  _DetailViewState({@required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                pinned: true,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                  background:
                      Image.network(details.imageUrl, fit: BoxFit.fitWidth),
                ),
              )
            ];
          },
          body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(margin: EdgeInsets.only(top: 5)),
                  Text(
                    details.title,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                          child: Text(
                        details.authors,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.grey),
                      )),
                      Text(details.publishedDate.toString().substring(0, 10))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                  ),
                  Text(details.articleAbstract),
                ],
              )),
        ),
      ),
    );
  }
}
