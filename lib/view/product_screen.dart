import 'dart:convert';

import 'package:api_learn/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<ProductModel> getProductData() async {
      final response = await http.get(Uri.parse(
          'https://mocki.io/v1/e0b9fdc2-94fd-4588-89b3-e6ab0342ce90'));

      var data = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        return ProductModel.fromJson(data);
      } else {
        return ProductModel.fromJson(data);
      }
    }

    return Scaffold(

      // backgroundColor: Colors.white,
      body: Column(
        children: [
          FutureBuilder(
            future: getProductData(),
            builder: (context, snapshot) {

              if(!snapshot.hasData) {
                return const Center(child: Text('Loading...'),);
              }

               else {
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        // Text(snapshot.data!.data![index].title.toString()),


                        ListTile(

                          leading: CircleAvatar(foregroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),radius: 30,),
                          title:  Text(snapshot.data!.data![index].shop!.name.toString(),style:const  TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                          subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString(),style:const  TextStyle(fontSize: 16, fontWeight: FontWeight.w200),),

                          // subtitle:,

                        ),

                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            // color: Colors.red,
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 1,

                            // padding: const EdgeInsets.all(8),
                            
                            child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: snapshot.data!.data![index].images!.length,itemBuilder: (context, pos) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Image.network(snapshot.data!.data![index].images![pos].url.toString(),fit: BoxFit.fill,),
                              );
                            },),                        ),
                        ),



                      ],
                    );
                  },
                ),
              );

               }
            },
          )
        ],
      ),
    );
  }
}
