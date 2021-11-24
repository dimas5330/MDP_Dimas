import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class DetailDomestic extends StatefulWidget {
  final String title;
  final String imageToUrl;
  const DetailDomestic(
      {Key? key, required this.title, required this.imageToUrl})
      : super(key: key);

  @override
  State<DetailDomestic> createState() => _DetailDomesticState();
}

class _DetailDomesticState extends State<DetailDomestic> {
  late Future<Desc> detailNews;

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
                              height: 5,
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
  final String urlToImage;
  final String description;

  Desc({
    required this.title,
    required this.urlToImage,
    required this.description,
  });

  factory Desc.fromJson(Map<String, dynamic> json) {
    return Desc(
      title: json['title'],
      urlToImage: json['urlToImage'],
      description: json['description'],
    );
  }
}

Future<Desc> fetchDesc(id) async {
  final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=id&category=business&apiKey=efb24ab02e314ba2a2dbea4dcd0d92a2'));

  if (response.statusCode == 200) {
    var synopsisJson = jsonDecode(response.body);
    return Desc.fromJson(synopsisJson);
  } else {
    throw Exception('Failed to load episodes');
  }
}
