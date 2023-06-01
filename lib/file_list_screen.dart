import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'image_screen.dart';

class FileListScreen extends StatefulWidget {
  String serverIp = '0.0.0.0';
  FileListScreen({super.key, required this.serverIp});

  @override
  _FileListScreenState createState() => _FileListScreenState();
}

class _FileListScreenState extends State<FileListScreen> {
  List<String> files = [];
  @override
  void initState() {
    super.initState();
    fetchFiles(widget.serverIp);
  }

  Future<void> fetchFiles(String serverIp) async {
    try {
      print('http://$serverIp:5000/files');
      final response = await http.get(Uri.parse('http://$serverIp:5000/files'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          files = List<String>.from(jsonData);
        });
      } else {
        print('Failed to fetch files');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File List'),
      ),
      body: ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(files[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageScreen(fileName: files[index], serverIp: widget.serverIp,),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
