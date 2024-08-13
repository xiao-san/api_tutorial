import 'dart:convert';

import 'package:api_learn/model/user_model.dart';
import 'package:api_learn/photo_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    List<User> getData = [];


    Future<List<User>> getApiData() async {
      var response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      var data = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        for (Map i in data) {
          getData.add(User.fromJson(i));
        }
        return getData;
      } else {
        return getData;
      }
    }

    List<String> apiList = [
      'User API',
      'Photo API'
    ];
    List<IconData> iconList = [
        Icons.person,
        Icons.photo_outlined,
    ];

    int selectedPageIndex = 0;


  @override
  Widget build(BuildContext context) {
    // int i = 0;

    return Scaffold(
      appBar: AppBar(
          //  title: const Text('App'),
          ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 10),
              height: 100,
              width: double.maxFinite,
              color: const Color(0xffffcd02),

              child: const Text('Menu',style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),),
            ),

          Expanded(
            child: ListView.builder(itemCount: 2,itemBuilder: (context, index) {
              return ListTile(
                title: Text(apiList[index]),
                leading:  Icon(iconList[index]),
                onTap: () {
                   setState(() {
                   selectedPageIndex = index;
                   });
                },
              );
            },),
          )
          ],
        ),
      ),
      body: selectedPageIndex == 0 ?
      
       FutureBuilder<List<User>>(
        future: getApiData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          } else {
            return ListView.builder(
              itemCount: getData.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(getData[index].id.toString()),
                      Text(
                        getData[index].title.toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(getData[index].body.toString()),
                    ],
                  ),
                );
              },
            );
          }
        },
      ) : const PhotoScreen()
    );
  }
}
