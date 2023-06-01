import 'package:flutter/material.dart';
import 'package:tiff_img/file_list_screen.dart';

class IpAddressScreen extends StatefulWidget {
  const IpAddressScreen({super.key});

  @override
  _IpAddressScreenState createState() => _IpAddressScreenState();
}

class _IpAddressScreenState extends State<IpAddressScreen> {
  String ipAddress = '';

  void updateIpAddress(String value) {
    setState(() {
      ipAddress = value;
    });
  }

  void navigateToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FileListScreen(serverIp: ipAddress),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter IP Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'IP Address',
              ),
              onChanged: (value) {
                updateIpAddress(value);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: navigateToNextScreen,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}