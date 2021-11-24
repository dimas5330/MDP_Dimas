import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:ta_mdp/pages/home_page.dart';

class DetailAir extends StatefulWidget {
  final String title;
  const DetailAir({Key? key, required this.title}) : super(key: key);

  @override
  State<DetailAir> createState() => _DetailAirState();
}

class _DetailAirState extends State<DetailAir> {
  late Future<Desc> detailNews;

  @override
  void initState() {
    super.initState();
    detailNews = fetchDesc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Desc>(
            future: detailNews,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.network(snapshot.data!.urlToImage),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              snapshot.data!.description,
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.justify,
                            )
                          ],
                        ),
                      ),
                    ]);
              } else if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong :('));
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}

class Desc {
  final String title;
  final String description;
  final String urlToImage;

  Desc({
    required this.title,
    required this.description,
    required this.urlToImage,
  });

  factory Desc.fromJson(Map<String, dynamic> json) {
    return Desc(
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage'],
    );
  }
}

Future<Desc> fetchDesc() async {
  final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=id&category=business&apiKey=efb24ab02e314ba2a2dbea4dcd0d92a2'));

  if (response.statusCode == 200) {
    var articleDescJson = jsonDecode(response.body)['articles'] as List;
    return articleDescJson
        .map((detailNews) => Desc.fromJson(detailNews))
        .toList();
  } else {
    throw Exception('Failed to load shows');
  }
}
