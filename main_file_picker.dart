import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Picker Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _names = [];
  List<String> _ages = [];
  List<String> _cities = [];

  void _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      List<String> lines = await file.readAsLines();
      setState(() {
        _names = [];
        _ages = [];
        _cities = [];
        for (String line in lines) {
          List<String> values = line.split(',');
          _names.add(values[0]);
          _ages.add(values[1]);
          _cities.add(values[2]);
        }
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Picker Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _selectFile,
              child: Text('Select a text file'),
            ),
            SizedBox(height: 20),
            Text(
              'Selected file contents:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _names.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_names[index]),
                    subtitle: Text('${_ages[index]}, ${_cities[index]}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
