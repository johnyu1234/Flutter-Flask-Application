import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Dio Form Request Tutorial'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
// ImagePicker to get image from app 
  final String endPoint = 'http://192.168.31.102:5000/upload';
    File file;
    final picker =ImagePicker();
Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      file =File(pickedFile.path);
      print('done');
      _upload(file);
      setState(() {});
    }
}
  
// uses dio as http request
  void _upload(File file) async {
    String fileName = file.path.split('/').last;
    print(fileName);
// uses FormData format to do the http request
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    Dio dio = new Dio();

    dio.post(endPoint, data: data).then((response) {
      var jsonResponse = jsonDecode(response.toString());
      print(jsonResponse);
    }).catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getImage();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}