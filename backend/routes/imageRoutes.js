const express = require('express');
const multer = require('multer');
const tf = require('@tensorflow/tfjs');
const mobilenet = require('@tensorflow-models/mobilenet');
const router = express.Router();
const fs = require('fs');
const path = require('path');

// Check if uploads folder exists, if not create it
const uploadDir = path.join(__dirname, '../uploads/');
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir);
}

// Set up Multer for file uploads
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, uploadDir);
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + '-' + file.originalname);
  }
});

const upload = multer({ storage: storage });

// Function to load image and perform prediction
const classifyImage = async (imagePath) => {
  // Read the image file
  const imageBuffer = fs.readFileSync(imagePath);

  // Decode the image into a tensor
  const imageTensor = tf.node.decodeImage(imageBuffer, 3);

  // Load the MobileNet model
  const model = await mobilenet.load();

  // Make a prediction on the image
  const predictions = await model.classify(imageTensor);

  return predictions;
};

// Route to handle image uploads and classification
router.post('/upload', upload.single('image'), async (req, res) => {
  try {
    // Log to check if the file is uploaded successfully
    console.log(req.file);

    if (!req.file) {
      return res.status(400).json({ message: 'No file uploaded' });
    }

    const imagePath = path.join(__dirname, '../uploads/', req.file.filename);

    // Perform image classification
    const predictions = await classifyImage(imagePath);

    // Send the predictions as a response
    res.json({ message: 'Image processed', predictions: predictions });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Failed to analyze the image', error });
  }
});

module.exports = router;