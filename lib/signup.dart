import 'dart:convert';

import 'package:api/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, password)async{
    try{
      Response response = await post(
        Uri.parse('https://reqres.in/api/register'),
        body: {
          'email' : email,
          'password' : password,
        }
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
        print('account created successfully');
      }else{
        print('failed');
      }
    }catch(e){
      print(e.toString());
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
        title: Text("Sign Up Api",style: TextStyle(fontSize: 50,color: Colors.pinkAccent,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadImage()));
              },
              child: Container(
                height: 20,
                width: 100,
                child: Center(child: Text("Tap here",style: TextStyle(color: Colors.pink),)),
              ),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                login(emailController.text.toString(), passwordController.text.toString());
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text('Sign Up',style: TextStyle(color: Colors.pink),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
