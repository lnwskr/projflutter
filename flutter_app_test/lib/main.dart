import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(/*title: 'FirztAir'*/),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Column(
        children: <Widget>[
          TextButton(
            child: const Text('Storage'),
            onPressed: () {
              filePicker(); // function
            },
          ),
          TextButton(
            child: const Text('Camera'),
            onPressed: () {
              CameraPicker(); // function
            },
          ),
          const SizedBox(
            height: 20,
          ),
          image == null
              ? Text("No Image Found")
              : // if image == null
              Image.file(
                  File(image!.path),
                  width: 250,
                  fit: BoxFit.cover,
                )
        ],
      ))),
    );
  }

  void filePicker() async {
    try {
      final XFile? selectImage =
          await _picker.pickImage(source: ImageSource.gallery);
      // print(selectImage!.path);
      setState(() {
        image = selectImage;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void CameraPicker() async {
    try {
      final XFile? selectImage =
          await _picker.pickImage(source: ImageSource.camera);
      // print(selectImage!.path);
      setState(() {
        image = selectImage;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }
}


/*
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: "Camera App",
    home: LandingScreen(),
  ));
}

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  File  imageFile = File('');

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture as File;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker().getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture as File;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text("Make a choice"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _decideImageView() {
    if (imageFile == Null) {
      return Text("No Image Selected");
    } else {
      Image.file(imageFile, width: 400, height: 400);
    }
    return Text("");
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
              child: Text("Select Image"),
            )
          ],
        ),
      )),
    );
  }
}
*/