import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Demo',
      home: FileDemo(),
    );
  }
}

class FileDemo extends StatefulWidget {
  @override
  _FileDemoState createState() => _FileDemoState();
}

class _FileDemoState extends State<FileDemo> {
  List<String> _names = [];
  List<String> _ages = [];
  List<String> _cities = [];

  void _readFile() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File file = File('${appDocDir.path}/data.txt');
      String contents = await file.readAsString();
      List<String> lines = contents.split('\n');
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
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _readFile,
              child: Text('Read File'),
            ),
            SizedBox(height: 20),
            Text(
              'Contents of data.txt:',
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
