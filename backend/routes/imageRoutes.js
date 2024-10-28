const express = require('express');
const multer = require('multer');
const mobilenet = require('@tensorflow-models/mobilenet');
const tf = require('@tensorflow/tfjs');
const Image = require('../models/Image');  // Import the Image model

const router = express.Router();
const upload = multer({ dest: 'uploads/' });

router.post('/upload', upload.single('image'), async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ error: 'No file uploaded' });
    }

    const imageBuffer = fs.readFileSync(req.file.path);
    const decodedImage = tf.node.decodeImage(imageBuffer);
    const model = await mobilenet.load();
    const predictions = await model.classify(decodedImage);

    decodedImage.dispose();

    // Save image details and predictions to MongoDB
    const newImage = new Image({
      filename: req.file.filename,
      classification: predictions,
    });

    await newImage.save();

    res.status(200).json({
      message: 'Image processed and saved to database',
      predictions: predictions,
    });
  } catch (error) {
    console.error('Error processing image:', error);
    res.status(500).json({ error: 'Failed to process image' });
  }
});

router.get('/history', async (req, res) => {
  try {
    const images = await Image.find().sort({ uploadedAt: -1 });
    res.status(200).json(images);
  } catch (error) {
    console.error('Error fetching image history:', error);
    res.status(500).json({ error: 'Failed to fetch image history' });
  }
});

module.exports = router;