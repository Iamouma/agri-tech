# Farmguard.

A Flutter-based mobile application that detects diseases in crops. This project is built using Flutter for the frontend and Node.js/Express.js for the backend. The application allows users to upload images of plants and receive disease classification results. The backend utilizes TensorFlow.js with the MobileNet model to identify potential diseases in plants.

## Table of Contents

0. [Introduction](#introduction)

1. [Features](#features)

2. [Project Structure](#project-structure)
   
3. [Installation](#installation)
 
4. [Running the Application](#running-the-application)

5. [API Endpoints](#api-endpoints)

6. [Contributing](#contributing)

### Introduction

This project is designed to assist farmers and agricultural experts in identifying plant diseases through image analysis. Users can upload an image of a plant leaf via the mobile app, and the image is then sent to the backend, where a trained MobileNet model processes it to predict the disease.

### Features

  * Image Upload: Users can select an image from their device’s gallery.
    
  * Image Classification: The backend classifies the image to detect plant diseases using TensorFlow.js and the MobileNet model.
    
  * Results Display: After classification, the app displays the detected plant disease and the confidence level.
    
  * REST API: The app communicates with a Node.js backend to process images and receive classification results.


###  Project Structure

##### Backend

The backend is built using Node.js and Express.js, integrating TensorFlow.js and the MobileNet model to classify plant diseases. It handles file uploads, processes images, and returns predictions.

    backend/
    │
    ├── routes/
    │   └── imageRoutes.js      # Routes for handling image uploads and classification
    ├── uploads/                # Stores uploaded images
    ├── index.js                # Main server entry point
    ├── package.json            # Backend dependencies and scripts
    └── README.md               # Backend readme
    
##### Flutter Frontend

The Flutter app allows users to select images from their gallery and send them to the backend. It displays the disease classification results to the user.

    flutter_frontend/
    │
    ├── lib/
    │   ├── main.dart                   # Main entry point for Flutter
    │   └── image_upload_screen.dart     # UI for selecting and uploading images
    ├── pubspec.yaml                    # Flutter dependencies
    └── README.md                       # Frontend readme

    
### Installation

##### Backend Setup

Clone the repository:

    git clone https://github.com/yourusername/agri-tech.git
    cd backend

Install Node.js dependencies: Make sure you have Node.js installed. Then run:

    npm install

Create uploads directory: If not already created, make a directory to store uploaded images:

    mkdir uploads

Run the backend server: Start the server on port 5000 by running:

    node index.js
    
You should see the message:

    Server running on port 5000

##### Flutter Frontend Setup

Navigate to the frontend directory:

    cd farmguard

Install Flutter dependencies: Make sure you have Flutter installed. Then run:

    flutter pub get

Update the Backend URL: In the image_upload_screen.dart file, update the Uri with your backend server’s IP address or domain:

    final uri = Uri.parse('http://your-backend-server-ip:5000/api/images/upload');
    
Run the Flutter app: You can run the app on an emulator or a physical device using:

    flutter run

### Running the Application

##### Running the Backend
To start the backend server, navigate to the backend directory and run:

    node index.js

This will start the server at http://localhost:5000. Ensure your device/emulator is connected to the same network.

##### Running the Flutter App

To start the Flutter app, navigate to the flutter_frontend directory and run:

    flutter run

Make sure the device or emulator you're using is connected to the same network as your backend server.

### API Endpoints

##### POST /api/images/upload

This endpoint accepts an image file via a multipart/form-data POST request and returns plant disease classification results.

  * URL: http://your-backend-server-ip:5000/api/images/upload
  * Method: POST
  * Body: Multipart form-data with an image file (image field).

Sample Request

    curl -X POST http://localhost:5000/api/images/upload \
      -F 'image=@/path/to/image.jpg'
      
Sample Response

    {
      "message": "Image processed",
      "predictions": [
        {
          "className": "Tomato Blight",
          "probability": 0.90
        },
        {
          "className": "Healthy",
          "probability": 0.07
        }
      ]
     }


### Contributing

If you'd like to contribute to this project:

 * Fork the repository.
 * Create a new branch for your feature or bugfix (git checkout -b feature-branch).
 * Commit your changes (git commit -am 'Add new feature').
 * Push to the branch (git push origin feature-branch).
 * Create a pull request explaining your changes.
