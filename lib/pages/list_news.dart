import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ta_mdp/pages/detail_news_domestic.dart';
import 'dart:convert';

import 'detail_news.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  late Future<List<Show>> shows;
  late Future<List<Shows>> showair;
  @override
  void initState() {
    super.initState();
    shows = fetchShows();
    showair = fetchShow();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Market News'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(7),
            child: const Text(
              'Foreign Market News',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder(
            builder: (context, AsyncSnapshot<List<Shows>> snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                    height: 230,
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) => Card(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                          title: snapshot.data![index].title,
                                          urlToImage:
                                              snapshot.data![index].urlToImage,
                                        )));
                          },
                          child: Container(
                            height: 200,
                            width: 150,
                            child: Column(children: [
                              Stack(
                                children: [
                                  Image.network(
                                    snapshot.data![index].urlToImage,
                                    height: 200,
                                    width: 150,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  ),
                                  Text(
                                    snapshot.data![index].title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ));
              } else if (snapshot.hasError) {
                return const Center(child: Text('Failed to load Data'));
              }
              return const CircularProgressIndicator();
            },
            future: showair,
          ),
          Container(
            padding: EdgeInsets.all(7),
            child: const Text(
              'Domestic Market News',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              builder: (context, AsyncSnapshot<List<Show>> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailDomestic(
                                      title: snapshot.data![index].title,
                                      imageToUrl:
                                          snapshot.data![index].urlToImage),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 100,
                              child: (Row(
                                children: [
                                  Image.network(
                                    snapshot.data![index].urlToImage,
                                  ),
                                  Column(
                                    children: [
                                      Text(snapshot.data![index].title),
                                    ],
                                  )
                                ],
                              )),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong :('));
                }
                return const CircularProgressIndicator();
              },
              future: shows,
            ),
          ),
        ],
      ),
    );
  }
}

class Show {
  final String title;
  final String urlToImage;

  Show({
    required this.title,
    required this.urlToImage,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      title: json['title'],
      urlToImage: json['urlToImage'],
    );
  }
}

Future<List<Show>> fetchShows() async {
  final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=efb24ab02e314ba2a2dbea4dcd0d92a2'));

  if (response.statusCode == 200) {
    var articleShowsJson = jsonDecode(response.body)['article'] as List;
    return articleShowsJson.map((show) => Show.fromJson(show)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}

class Shows {
  final String title;
  final String urlToImage;

  Shows({required this.title, required this.urlToImage});

  factory Shows.fromJson(Map<String, dynamic> json) {
    return Shows(
      title: json['title'],
      urlToImage: json['urlToImage'],
    );
  }
}

Future<List<Shows>> fetchShow() async {
  final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=id&category=business&apiKey=efb24ab02e314ba2a2dbea4dcd0d92a2'));

  if (response.statusCode == 200) {
    var articleShowsJson = jsonDecode(response.body)['article'] as List;
    return articleShowsJson.map((showair) => Shows.fromJson(showair)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}
