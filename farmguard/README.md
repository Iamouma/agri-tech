## Farmguard

A Flutter-based mobile application that detects diseases in crops using machine learning. The app allows users to capture or upload images of crops, process these images to predict possible diseases, and provide relevant treatment recommendations. The backend is powered by Firebase, which handles user authentication, image storage, and cloud functions for running the machine learning model.

## Table of Contents

0. [Introduction](#introduction)

1. [Features](#features)

2. [Technology Stack](#technology-stack)

3. [Architecture](#architecture)

4. [Setup and Installation](#setup-and-installation)

5. [Firebase Setup](#firebase-setup)

6. [Usage](#usage)

7. [Model Training](#model-trianing)

8. [Contributing](#contributing)

### Introduction

The farmguard is designed to assist farmers and agricultural experts in identifying crop diseases at an early stage. By simply capturing or uploading an image of a crop, users can get an instant diagnosis of possible diseases along with recommended treatments. This application leverages machine learning to analyze crop images and is built using Flutter for the frontend and Firebase for backend services.

### Features

  * User Authentication: Secure login and registration using Firebase Authentication.

  * Image Capture & Upload: Users can capture images using the camera or upload them from the gallery.

  * Disease Detection: Machine learning model processes the image and predicts possible crop diseases.

  * Treatment Recommendations: Provides suggestions and treatments for the identified disease.

  * History Tracking: Users can view a history of past analyses.


### Technology Stack

  * Frontend: Flutter

  * Backend: Firebase (Authentication, Cloud Firestore, Cloud Storage, Cloud Functions)

  * Machine Learning: TensorFlow.js for model deployment, Python for model training

  * Other Tools: Git, Visual Studio Code, Firebase CLI

### Architecture

The application architecture is a combination of client-server and serverless models:

  * Client: Flutter app running on Android/iOS.

  * Backend: Firebase serves as the backend, providing services like authentication, database, storage, and cloud functions.

  * Machine Learning: The model is trained offline using Python and TensorFlow. For inference, the model is deployed using TensorFlow.js and executed within Firebase Cloud Functions.

### Setup and Installation

##### Prerequisites

  * Flutter SDK: Install Flutter from the official site.

  * Firebase Account: Create a Firebase account at firebase.google.com.

  * Python: For model training, you need Python 3.x installed.

##### Installation Steps

Clone the Repository

    git clone https://github.com/yourusername/agri-tech.git

    cd farmguard

Install Flutter Dependencies

    flutter pub get
    
Set Up Firebase

    Follow the Firebase Setup section below.

Run the App

    flutter run
    
### Firebase Setup

Step 1: Create a Firebase Project

    Go to the Firebase Console.
    Click on "Add Project" and follow the steps to create a new project.
    Register your app by selecting the Android/iOS icon and following the instructions to download the google-services.json or GoogleService-Info.plist file.
    
Step 2: Add Firebase SDK to Your Flutter App

    Place the google-services.json (for Android) or GoogleService-Info.plist (for iOS) file in the appropriate directory (android/app or ios/Runner).

Open your pubspec.yaml file and add the necessary Firebase dependencies:

    dependencies:
      firebase_core: latest_version
      firebase_auth: latest_version
      cloud_firestore: latest_version
      firebase_storage: latest_version
      firebase_functions: latest_version
      
Initialize Firebase in your Flutter app:

    import 'package:firebase_core/firebase_core.dart';
    
    void main() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      runApp(MyApp());
    }
    
Step 3: Set Up Firebase Services

  * Authentication: Enable Email/Password sign-in method in Firebase Authentication.

  * Firestore: Create a Firestore database in test mode for initial development.

  * Storage: Set up Firebase Storage for image uploads.

  * Cloud Functions: Deploy a cloud function for image processing (see Deployment).

### Usage
##### Registration and Login

New users can sign up using email and password.

Existing users can log in to access the app features.

##### Upload or Capture Image

Users can either capture a photo using their device's camera or upload an image from their gallery.

##### Disease Detection

Once the image is uploaded, it is processed by the machine learning model to predict the possible disease.
View Results and Recommendations

After processing, the app displays the predicted disease along with detailed treatment recommendations.

#### View History

Users can view a history of all the images they have analyzed.

### Model Training
##### Data Collection

Gather images of crops with various diseases.

Use publicly available datasets like PlantVillage or create your own dataset.

##### Model Training
Use Python and TensorFlow/Keras to train a convolutional neural network (CNN).

Example code:

    import tensorflow as tf
    from tensorflow.keras import layers, models
    
    model = models.Sequential([
        layers.Conv2D(32, (3, 3), activation='relu', input_shape=(224, 224, 3)),
        layers.MaxPooling2D((2, 2)),
        layers.Conv2D(64, (3, 3), activation='relu'),
        layers.MaxPooling2D((2, 2)),
        layers.Conv2D(128, (3, 3), activation='relu'),
        layers.Flatten(),
        layers.Dense(512, activation='relu'),
        layers.Dense(num_classes, activation='softmax')
    ])
    
    model.compile(optimizer='adam',
                  loss='categorical_crossentropy',
                  metrics=['accuracy'])
    
    model.fit(train_images, train_labels, epochs=10, validation_data=(test_images, test_labels))
    
##### Model Export

Convert the trained model to TensorFlow.js format for deployment:

    tensorflowjs_converter --input_format=keras model.h5 ./model


### Contributing

Contributions are welcome, Please follow these steps:

Fork the repository.

Create a new branch (git checkout -b feature-branch).

Commit your changes (git commit -am 'Add new feature').

Push to the branch (git push origin feature-branch).

Create a pull request.
