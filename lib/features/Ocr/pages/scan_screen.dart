import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:food_advisor/features/Ocr/pages/ocr_result_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  File? _image;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController =
        CameraController(_cameras!.first, ResolutionPreset.medium);
    await _cameraController!.initialize();
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    final image = await _cameraController!.takePicture();
    setState(() {
      _image = File(image.path);
    });

    // Directly navigate to the OCR result screen with the image
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OcrResultScreen(
          image: _image!,
          tag:
              'ocr_hero_${DateTime.now().millisecondsSinceEpoch}', // Pass a unique tag for the hero transition
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      // Directly navigate to the OCR result screen with the picked image
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OcrResultScreen(
            image: _image!,
            tag:
                'ocr_hero_${DateTime.now().millisecondsSinceEpoch}', // Pass a unique tag for the hero transition
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Scan Chips Packet')),
      body: Stack(
        children: [
          CameraPreview(_cameraController!), // Display live camera feed
          Positioned(
            bottom: 16,
            left: 16,
            child: FloatingActionButton(
              onPressed: _pickImageFromGallery,
              child: const Icon(Icons.photo_library),
              tooltip: 'Upload from Gallery',
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        child: const Icon(Icons.camera_alt),
        tooltip: 'Capture Image',
      ),
    );
  }
}
