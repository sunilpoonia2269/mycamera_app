import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;

  Future openCamera() async {
    var imageClicked = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = imageClicked;
    });
  }

  Future openGallery() async {
    var gallery = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = gallery;
    });
  }

  Future<void> _optionsDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      "Take a Picture",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, openCamera());
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                  ),
                  GestureDetector(
                      child: Text(
                        "Select Image from Gallery",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context, openGallery());
                      }),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Camera App"),
      ),
      body: Center(
        child: _image == null
            ? Text(
                'No Image Picked',
                style: TextStyle(fontSize: 20.0),
              )
            : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _optionsDialogBox,
        child: Icon(Icons.add_a_photo),
        tooltip: 'Open Camera',
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
    );
  }
}
