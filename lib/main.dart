import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(new MaterialApp(
    title: "Private Photo Gallery",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File imageFile;
  final picker = ImagePicker();

  _openGallery() async {
    var picture = await picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture as File;
    });
    Navigator.of(context).pop();
  }

  _openCamera() async {
    var picture = await picker.getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture as File;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a choice!"),
            content: SingleChildScrollView(
              child: ListBody(children: <Widget>[
                GestureDetector(
                  child: Text('Gallery'),
                  onTap: () {
                    _openGallery();
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Camera'),
                  onTap: () {
                    _openCamera();
                  },
                )
              ]),
            ),
          );
        });
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Text("No Image Selected!");
    } else {
      Image.file(imageFile, width: 400, height: 400);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _decideImageView(),
              RaisedButton(
                onPressed: () {
                  _showChoiceDialog(context);
                },
                child: Text('Select Image: '),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
