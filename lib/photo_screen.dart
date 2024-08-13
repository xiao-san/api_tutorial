import 'dart:convert';

import 'package:api_learn/model/photo_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotoScreen extends StatelessWidget {
  const PhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Photos> photosList = [];

    Future<List<Photos>> getPhotos() async {
      var response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
      var data = jsonDecode(response.body.toString());

      // Used this method of object to add data to the list id fromJson model is not available in Model

      if (response.statusCode == 200) {
        for (Map i in data) {
          final Photos photos = Photos(
              id: i['id'],
              title: i['title'],
              url: i['url'],
              thumbnailUrl: i['thumbnailUrl']);
          photosList.add(photos);
        }
        return photosList;
      } else {
        throw Exception('expecption caught');
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: getPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('No data Found'),
            );
          } else {
            return ListView.builder(
              itemCount: photosList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(photosList[index].url.toString())),
                      title: Text(photosList[index].title.toString()),
                    ),
                    Image.network(photosList[index].thumbnailUrl),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
