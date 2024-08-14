import 'dart:convert';

import 'package:api_learn/model/user_details_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    List<UsersDetailModel> userDetailsList = [];

    Future<List<UsersDetailModel>> getUserDetails() async{

      var response =await  http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      var data = jsonDecode(response.body.toString());
      
      if(response.statusCode == 200) {
      for(Map<String,dynamic> i in data) {
      userDetailsList.add(UsersDetailModel.fromJson(i));
      }
      return userDetailsList;
      }

      else {
          throw Exception('Exception Caught');
      }

    }
    return Scaffold(
      body: FutureBuilder(future: getUserDetails(), builder: (context, snapshot) {
        return ListView.builder(itemCount: userDetailsList.length,itemBuilder: (context,index) {
          return Column(
            children: [
              CustomRow(name: 'Name', title: snapshot.data![index].name.toString()),
              CustomRow(name: 'Address',title: snapshot.data![index].address.toString()),
            ],
          );
        });
      },)
    );
  }
}

class CustomRow extends StatelessWidget {
  const CustomRow({super.key, required this.title, required this.name});

   final String title;
   final String name;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name),
            Text(title),
          ],
        ),
      ),
    );
  }
}