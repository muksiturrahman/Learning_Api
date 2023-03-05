import 'dart:convert';

import 'package:api/example_five.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({Key? key}) : super(key: key);

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {

  var data;
  Future<void>getUserApi ()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
    }else{

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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ExampleFive()));
            },
            child: Container(
              height: 20,
              width: 100,
              child: Center(child: Text("Tap here",style: TextStyle(color: Colors.pink),)),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Text("Loading");
                }else{
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index){
                      return Card(
                        child: Column(
                          children: [
                            ReuseableRow(title: 'Name', value: data[index]['name'].toString(),),
                            ReuseableRow(title: 'Username', value: data[index]['username'].toString(),),
                            ReuseableRow(title: 'Address', value: data[index]['address']['street'].toString(),),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}


class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({Key? key, required this.title, required this.value }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
