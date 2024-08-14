import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserDetailsScreen2 extends StatelessWidget {
  const UserDetailsScreen2({super.key});

  @override
  Widget build(BuildContext context) {

    var userData ;

    Future<void> getUserApi () async{

      var response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
       userData = jsonDecode(response.body.toString());
      if(response.statusCode == 200 ) {

        return userData;
      }

      else {
        return debugPrint('error loading data');
      }
    }
    return Scaffold(
      backgroundColor: Colors.black,

      body: FutureBuilder(future: getUserApi(), builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center( child:  Text('Loading'),);
        }

        else {
        return ListView.builder(itemCount: userData.length,itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                // Text(userData[index]['name']),
                // Text(userData[index]['username'])
            
                CustomRow(title: 'Name:', name: userData[index]['name']),
                CustomRow(title: 'Username:', name: userData[index]['username']),
                CustomRow(title: 'Email:', name: userData[index]['email']),
                CustomRow(title: 'City:', name: userData[index]['address']['city']),
                CustomRow(title: 'latitude:', name: userData[index]['address']['geo']['lat']),
                CustomRow(title: 'langtitude:', name: userData[index]['address']['geo']['lng']),
              ],
            ),
          );
        },);
        }
      },),
    );
  }
}

class CustomRow extends StatelessWidget {
  const CustomRow({super.key, required this.title, required this.name});

   final String title;
   final String name;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style:const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          Text(name,style:const TextStyle(fontSize: 16),),
        ],
      ),
    );
  }
}