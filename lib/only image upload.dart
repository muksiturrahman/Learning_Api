import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class OnlyUpload extends StatefulWidget {
  const OnlyUpload({Key? key}) : super(key: key);

  @override
  State<OnlyUpload> createState() => _OnlyUploadState();
}

class _OnlyUploadState extends State<OnlyUpload> {

  File? image;
  final _picker = ImagePicker();

  Future getImage()async{
    final pickedFile = await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if(pickedFile!= null){
      image = File(pickedFile.path);
      setState(() {

      });
    }else{
      print('No image selected');
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
        title: Text("Upload Image",style: TextStyle(fontSize: 45,color: Colors.pinkAccent,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              getImage();
            },
            child: Container(
                child: image == null ? Center(child: Text('Pick Image'),):
                Container(
                  child: Center(
                    child: Image.file(
                      File(image!.path).absolute,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}
