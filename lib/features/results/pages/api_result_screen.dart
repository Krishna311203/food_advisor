import 'package:flutter/material.dart';
import 'dart:convert'; // To decode API response
import 'package:http/http.dart' as http;

class ApiResultScreen extends StatefulWidget {
  final String extractedText;

  const ApiResultScreen({required this.extractedText, Key? key})
      : super(key: key);

  @override
  _ApiResultScreenState createState() => _ApiResultScreenState();
}

class _ApiResultScreenState extends State<ApiResultScreen> {
  bool isLoading = true;
  String apiResponse = '';

  @override
  void initState() {
    super.initState();
    _fetchApiResponse();
  }

  Future<void> _fetchApiResponse() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.16:5000/api/ocr'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'recognizedText': widget.extractedText}),
      );

      if (response.statusCode == 200) {
        setState(() {
          apiResponse = jsonDecode(response.body)[
              'response']; // Assuming the API returns a field 'responseText'
          isLoading = false;
        });
      } else {
        setState(() {
          apiResponse = 'Failed to get a valid response';
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        apiResponse = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Response'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                apiResponse,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
    );
  }
}
