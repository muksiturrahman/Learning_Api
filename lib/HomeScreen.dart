import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/postsModels.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<PostsModels> postList = [];
  Future<List<PostsModels>> getPostApi () async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      postList.clear();
      for(Map i in data){
        postList.add(PostsModels.fromJson(i));
      }
      return postList;
    }else {
      return postList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(140),
          ),
        ),
        title: Text("Api",style: TextStyle(fontSize: 50,color: Colors.pinkAccent,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            height: 700,
            color: Colors.pinkAccent,
            child: Expanded(
              child: FutureBuilder(
                future: getPostApi(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Center(child: Text("Loading",style: TextStyle(fontSize:50,color: Colors.pinkAccent),));
                  }else{
                    return ListView.builder(
                      itemCount: postList.length,
                        itemBuilder: (context, index){
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(postList[index].title.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.pinkAccent),),
                                SizedBox(height: 20,),
                                Text(postList[index].body.toString(),style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.pinkAccent),),
                              ],
                            ),
                          ),
                        );
                      });
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
