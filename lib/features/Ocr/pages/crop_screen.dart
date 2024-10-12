import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'ocr_result_screen.dart';

class CropScreen extends StatefulWidget {
  final File image;

  const CropScreen({required this.image, Key? key}) : super(key: key);

  @override
  _CropScreenState createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  File? _croppedImage;

  Future<void> _cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: widget.image.path,
    );

    if (croppedFile != null) {
      setState(() {
        _croppedImage = File(croppedFile.path);
      });

      // Define a unique tag for the hero transition
      String tag = 'ocr_hero_${DateTime.now().millisecondsSinceEpoch}';

      // Navigate to the OCR result screen with the tag
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OcrResultScreen(
            image: _croppedImage!,
            tag: tag, // Pass the tag
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _cropImage(); // Start cropping when the screen opens
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Image'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              _cropImage(); // Crop the image when the check icon is pressed
            },
          ),
        ],
      ),
      body: Center(
        child: _croppedImage == null
            ? Image.file(widget.image) // Display the original image
            : Image.file(_croppedImage!), // Display cropped image if available
      ),
    );
  }
}
