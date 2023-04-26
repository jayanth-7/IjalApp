import 'dart:io';

import 'package:flutter/material.dart';

class TxtFileListScreen extends StatefulWidget {
  @override
  _TxtFileListScreenState createState() => _TxtFileListScreenState();
}

class _TxtFileListScreenState extends State<TxtFileListScreen> {
  List<File> _txtFiles = [];

  @override
  void initState() {
    super.initState();
    _loadTxtFiles();
  }

  void _loadTxtFiles() async {
    Directory directory = Directory('path/to/local/directory');
    List<File> txtFiles = await directory
        .list()
        .where((entity) =>
            entity is File && entity.path.endsWith('.txt') && entity.path.startsWith('sys'))
        .map((entity) => entity as File)
        .toList();
    setState(() {
      _txtFiles = txtFiles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TXT Files')),
      body: _txtFiles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _txtFiles.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_txtFiles[index].path),
                  onTap: () => _showTxtFileContent(_txtFiles[index]),
                );
              },
            ),
    );
  }

  void _showTxtFileContent(File txtFile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => TxtFileContentScreen(txtFile: txtFile),
      ),
    );
  }
}

class TxtFileContentScreen extends StatelessWidget {
  final File txtFile;

  TxtFileContentScreen({required this.txtFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(txtFile.path)),
      body: FutureBuilder<String>(
        future: txtFile.readAsString(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(snapshot.data!),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
