import 'package:flutter/material.dart';
import 'package:food_advisor/features/results/pages/api_result_screen.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:io';

class OcrResultScreen extends StatefulWidget {
  final File image;
  final String tag; // Tag for the Hero widget

  const OcrResultScreen({required this.image, required this.tag, Key? key})
      : super(key: key);

  @override
  _OcrResultScreenState createState() => _OcrResultScreenState();
}

class _OcrResultScreenState extends State<OcrResultScreen> {
  String extractedText = '';

  Future<void> _performOCR() async {
    final inputImage = InputImage.fromFile(widget.image);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    setState(() {
      extractedText = recognizedText.text;
    });
    textRecognizer.close();
  }

  @override
  void initState() {
    super.initState();
    _performOCR(); // Start OCR when the screen opens
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OCR Result')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Hero(
                tag: widget.tag, // Ensure this tag is unique for the transition
                child: Image.file(widget.image),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: TextEditingController(text: extractedText)
                  ..selection = TextSelection.fromPosition(TextPosition(
                      offset: extractedText.length)), // Place cursor at the end
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Extracted Text',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle the edited text
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ApiResultScreen(extractedText: extractedText),
                    ),
                  );
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
