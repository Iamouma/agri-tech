# Farmguard

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

#### Database Integration
This application uses MongoDB to store and manage image classification results. Each image uploaded and classified by the backend is saved in the database, along with relevant metadata.

 * Database Setup

To run this application with MongoDB, ensure you have MongoDB installed locally, or use a MongoDB cloud service such as MongoDB Atlas. The database connection URI is stored in an .env file for security.

Install MongoDB (skip if using MongoDB Atlas or another hosted service).

Create a .env file in the root directory with the following contents:


    MONGODB_URI=mongodb://localhost:27017/plantDiseaseDetection
    PORT=5000

 * MongoDB Schema

The data for each classified image is stored in a collection called images, using the following schema:

filename (String) - The name of the uploaded image file.

classification (Array) - An array of classification results, each containing:
className (String) - The name of the detected disease or object.

probability (Number) - The confidence level of the prediction (0 to 1).

uploadedAt (Date) - The timestamp of when the image was uploaded (defaults to the current date and time).

MongoDB Model Definition
In the backend code, this schema is defined using Mongoose in the models/Image.js file:

    const mongoose = require('mongoose');

    const imageSchema = new mongoose.Schema({
      filename: { type: String, required: true },
      classification: [
        {
          className: String,
          probability: Number,
        }
      ],
      uploadedAt: { type: Date, default: Date.now }
    });

    module.exports = mongoose.model('Image', imageSchema);

Saving Classification Results to MongoDB

After an image is classified by the TensorFlow model, the backend saves the image’s classification results and metadata to MongoDB:

The image file is uploaded and classified.

The classification result, including class names and probabilities, is saved to MongoDB.

The database entry includes the image filename and timestamp.

Viewing Classification History

The API provides an endpoint to retrieve a history of all classified images:

Endpoint: GET /api/images/history
Description: Returns a list of all classified images and their details, sorted by upload date (newest first).
Example response:

    [
      {
        "_id": "614b1a4f6f1b2b1b1a8f4e8f",
        "filename": "image_12345.jpg",
        "classification": [
          { "className": "Powdery Mildew", "probability": 0.95 },
          { "className": "Early Blight", "probability": 0.05 }
        ],
        "uploadedAt": "2024-10-10T10:30:00.000Z"
      }
    ]
    
Example Usage with MongoDB

Start the MongoDB server (if running locally): mongod

Run the backend server: node index.js

Access MongoDB data: You can use tools like MongoDB Compass or the mongo shell command to view and manage data in the plantDiseaseDetection database.

By storing classification results, this database integration allows users to maintain a history of analyzed images, making it easy to review past classifications or analyze trends in plant diseases.


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
