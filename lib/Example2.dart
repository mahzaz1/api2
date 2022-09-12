import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/user.dart';

class Example2 extends StatefulWidget {
   Example2({Key? key}) : super(key: key);

  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> {
  List<User> list = [];

  Future getApi() async{
    final response = await http.get(Uri.parse('https://randomuser.me/api/?results=150'));
    var data = jsonDecode(response.body);

    final result = data['results'] as List<dynamic>;


    list = result.map((e){
      final name = UserName(
        last: e['name']['last'],
        first: e['name']['first'],
        title: e['name']['title'],

      );

      final picture = UserPicture(
        large: e['picture']['large'],
        medium: e['picture']['medium'],
        thumbnail: e['picture']['thumbnail'],

      );

      return User(
        email: e['email'],
        gender: e['gender'],
        phone: e['phone'],
        name: name,
        picture: picture,
      );
    }).toList();

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Example 2'),),
      body: FutureBuilder(
        future: getApi(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(child: Center(child: CircularProgressIndicator(),),);
          }else{
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context ,index){

                  final user = list[index];

                  return ListTile(
                    tileColor: user.gender == 'male' ? Colors.black12 : Colors.white,
                    title: Text(user.name.first),
                    subtitle: Text(user.phone),
                    leading: ClipRRect(
                      child: Image.network(user.picture.thumbnail),
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

