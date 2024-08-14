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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomRow(name: 'Name:', title: snapshot.data![index].name.toString()),
                CustomRow(name: 'Username:',title: snapshot.data![index].address.toString()),
                CustomRow(name: 'Email:',title: snapshot.data![index].email.toString(),),
                CustomRow(name: 'Location:',title: '${snapshot.data![index].address!.city}, ${snapshot.data![index].address!.street}'),
              ],
            ),
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
    return Container(
      color: Colors.grey,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name,style:const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          Text(title,style:const TextStyle(fontSize: 16),),
        ],
      ),
    );
  }
}