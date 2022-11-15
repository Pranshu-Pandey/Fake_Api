import 'dart:convert';

import 'package:fake_api/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostsModel> postmodel = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: postmodel.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 130,
                    color: Colors.greenAccent,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "User id ${postmodel[index].userId}",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "Id data ${postmodel[index].id}",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "Title: ${postmodel[index].title}",
                          maxLines: 1,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "Body: ${postmodel[index].body}",
                          maxLines: 1,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<List<PostsModel>> getData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        postmodel.add(PostsModel.fromJson(index));
      }
      return postmodel;
    } else {
      return postmodel;
    }
  }
}
