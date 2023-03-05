import 'dart:convert';

import 'package:api/example_three.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({Key? key}) : super(key: key);

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotos()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photos);
      }
      return photosList;
    }else{
      return photosList;
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
          TextButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ExampleThree()));
            },
            child: Container(
              height: 20,
              width: 100,
              child: Center(child: Text("Tap here",style: TextStyle(color: Colors.pink),)),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
                builder: (context,AsyncSnapshot<List<Photos>> snapshot){
                  if(!snapshot.hasData){
                    return Center(child: Text("Loading",style: TextStyle(fontSize:50,color: Colors.pinkAccent),));
                  }else{
                  return ListView.builder(
                    itemCount: photosList.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                          ),
                          subtitle: Text(snapshot.data![index].title.toString()),
                          title: Text("Notes id: "+snapshot.data![index].id.toString()),
                        );
                    });
                  }
              }),
          )
        ],
      ),
    );
  }
}

class Photos {
  String title, url ;
  int id;
  Photos({required this.title, required this.url, required this.id});
}