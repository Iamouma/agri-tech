import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'disease_classifier.dart';
import '../services/storage_service.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image;
  final picker = ImagePicker();
  late DiseaseClassifier _classifier;

  @override
  void initState() {
    super.initState();
    _classifier = DiseaseClassifier(); // Initialize the classifier
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera); // Updated to pickImage

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);

        // Process the image
        _processImage(_image!);
      }
    });
  }

  void _processImage(File image) async {
    Uint8List imageBytes = await image.readAsBytes(); // Convert image to bytes
    List<dynamic> result = _classifier.classifyImage(imageBytes); // Get predictions

    // Display results
    Navigator.pushNamed(context, '/results', arguments: result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capture Image'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final ImagePicker _picker = ImagePicker();
  final StorageService _storageService = StorageService();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image != null) {
      String downloadUrl = await _storageService.uploadImage(_image!, 'image_name.jpg');
      print('Image URL: $downloadUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Image')),
      body: Column(
        children: [
          _image != null
              ? Image.file(_image!)
              : Text('No image selected.'),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Pick Image'),
          ),
          ElevatedButton(
            onPressed: _uploadImage,
            child: Text('Upload Image'),
          ),
        ],
      ),
    );
  }
}