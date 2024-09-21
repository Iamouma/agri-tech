import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage(File image) async {
    final uri = Uri.parse('http: backend-server-ip:5000/api/images/upload');

    // Create a multipart request
    var request = http.MultipartRequest('POST', uri);

    // Attach the image file
    var multipartFile = await http.MultipartFile.fromPath(
      'image',
      image.path,
    );

    request.files.add(multipartFile);

    // Send the request
    var response = await request.send();

    if (response.statusCode == 200) {
      print("Image uploaded successfully!");
    } else {
      print("Image upload failed with status: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Image')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(_image!)
                : Text('No image selected'),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_image != null) {
                  _uploadImage(_image!);
                }
              },
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}