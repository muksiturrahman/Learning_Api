import 'dart:convert';

import 'package:api/example_four.dart';
import 'package:api/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatefulWidget {
  const ExampleThree({Key? key}) : super(key: key);

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<UserModel> userList = [];
  Future<List<UserModel>> getUserApi ()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
   var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        userList.add(UserModel.fromJson(i));
      }
     return userList;
   }else{
     return userList;
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ExampleFour()));
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
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot){
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator());
                  }else{
                  return ListView.builder(
                    itemCount: userList.length,
                      itemBuilder: (context, index){
                        return Card(
                          child: Column(
                            children: [
                              ReuseableRow(title: 'Name :', value: snapshot.data![index].name.toString()),
                              ReuseableRow(title: 'Username :', value: snapshot.data![index].username.toString()),
                              ReuseableRow(title: 'Email :', value: snapshot.data![index].email.toString()),
                              ReuseableRow(title: 'Address :',
                                  value: snapshot.data![index].address!.city.toString()
                              ),
                            ],
                          ),
                        );
                      }
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

