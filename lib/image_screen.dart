import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImageScreen extends StatefulWidget {
  final String fileName;
  final String serverIp;

  const ImageScreen({super.key, required this.fileName, required this.serverIp});

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  Future<http.Response>? imageResponse;

  @override
  void initState() {
    super.initState();
    fetchImage();
  }

  void fetchImage() {
    final url = 'http://${widget.serverIp}:5000/image/${widget.fileName}';
    print('http://${widget.serverIp}:5000/image/${widget.fileName}');
    imageResponse = http.get(Uri.parse(url), headers: {
      'Access-Control-Allow-Origin': '*', // Replace * with the appropriate origin
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Origin, Content-Type',
    },).timeout(Duration(seconds: 30));;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Screen'),
      ),
      body: Center(
        child: FutureBuilder<http.Response>(
          future: imageResponse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.statusCode == 200) {
                final imageBytes = snapshot.data!.bodyBytes;
                return Image.memory(
                  imageBytes,
                  fit: BoxFit.contain,
                );
              } else {
                return const Text('Failed to load image');
              }
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
