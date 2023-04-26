import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text File Reader',
      home: TextFileReader(),
    );
  }
}

class TextFileReader extends StatefulWidget {
  @override
  _TextFileReaderState createState() => _TextFileReaderState();
}

class _TextFileReaderState extends State<TextFileReader> {
  String _fileContents = '';

  void _readFile(String filePath) async {
    try {
      final file = File(filePath);
      _fileContents = await file.readAsString();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );
    if (result != null) {
      String filePath = result.files.single.path!;
      _readFile(filePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text File Reader'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _openFilePicker,
                child: Text('Select File'),
              ),
              SizedBox(height: 20),
              if (_fileContents.isNotEmpty)
                Text(
                  'File Contents:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              if (_fileContents.isNotEmpty)
                SizedBox(height: 10),
              if (_fileContents.isNotEmpty)
                Text(
                  _fileContents,
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
