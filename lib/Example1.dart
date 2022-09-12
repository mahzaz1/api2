import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Example1 extends StatelessWidget {
   Example1({Key? key}) : super(key: key);

  List<dynamic> list = [];

  Future getApi() async{
    final response = await http.get(Uri.parse('https://randomuser.me/api/?results=150'));
    var data = jsonDecode(response.body);

    list = data['results'];
    return list;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Example 1'),),
      body: FutureBuilder(
        future: getApi(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(child: Center(child: CircularProgressIndicator(),),);
          }else {
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context ,index){

                  final user = list[index];

                  return ListTile(
                    // leading: ClipRect(child: ,),
                    title: Text(user['name']['first']),
                    subtitle: Text(user['email']),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(user['picture']['thumbnail']),
                    ),
                    trailing: Text('${index + 1}'),
                  );
                }
            );
          }
        },
      ),
    );
  }
}
