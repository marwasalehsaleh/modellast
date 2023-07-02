import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'api_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _response = '';

  Future<void> _getImageAndSend() async {
     try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      final file = File(pickedFile!.path);
      final response = await ApiService.sendImageAndGetResponse(file.path);
      setState(() {
        _response = response;
      });} on SocketException {
      setState(() {
        _response = 'Error: Cannot connect to server';
      });
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter API Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _getImageAndSend,
                child: Text('Choose Image and Send'),
              ),
              SizedBox(height: 20),
              Text(
                'Response from API:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                _response,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
