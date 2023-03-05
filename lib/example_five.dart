import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFive extends StatefulWidget {
  const ExampleFive({Key? key}) : super(key: key);

  @override
  State<ExampleFive> createState() => _ExampleFiveState();
}

class _ExampleFiveState extends State<ExampleFive> {
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
        ],
      ),
    );
  }
}
