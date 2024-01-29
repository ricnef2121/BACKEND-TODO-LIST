require("dotenv").config();
const express = require("express");
const logger = require("./src/utils/logger")
// const mongoose = require("mongoose");
// const MongoClient = require("mongodb").MongoClient;
const bodyParser = require("body-parser");
// const Item = require("./Item"); 

const app = express();
const PORT = process.env.PORT || 3000;

// mongoose.connect(process.env.MONGO_CONNECTION, {});

// const db = mongoose.connection;
// db.on("error", console.error.bind(console, "connection error"));
// db.once("open", function () {
//   console.log("connected");
// });

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const db = ({
  0: {
    id: 0,
    name: "new juan",
    description: "new sdddes",
  }
});

// Create
app.post("/items", async (req, res) => {
  try {
    const size = Object.keys(db).length
    const newElement = {
      id: size,
      name: "new juan",
      description: "new sdddes",
    }

    db[size] = { ...newElement }
    // const newItem = new Item(req.body);
    // const savedItem = await newItem.save();
    res.status(201).json(req.body);
  } catch (error) {
    logger.error(`error create item: ${error.message}`);
    res.status(400).json({ error: error.message });
  }
});

// Read
app.get("/items", async (req, res) => {
  try {
    logger.info("logged user")
    // const items = await Item.find();
    res.json(db);
  } catch (error) {
    logger.error(`error get items: ${error.message}`);
    res.status(500).json({ error: error.message });
  }
});

// Update
app.put("/items/:id", async (req, res) => {
  try {
    // const updatedItem = await Item.findByIdAndUpdate(req.params.id, req.body, {
    //   new: true,
    // });
    logger.info(`update item ${req.params.id ?? 0}`)
    db[req.params.id] = { ...db[req.params.id], ...req.body }
    res.json(db[req.params.id]);
  } catch (error) {
    logger.error(`error update item: ${error.message}`);
    res.status(400).json({ error: error.message });
  }
});

// Delete
app.delete("/items/:id", async (req, res) => {
  try {
    // const deletedItem = await Item.findByIdAndDelete(req.params.id);
    // res.json(deletedItem);
    delete db[req.params.id]
    logger.info(`delete item ${req.params.id ?? 0}`)
    res.json("OK");
  } catch (error) {
    logger.error(`delete item:${req.params.id} message: ${error.message}`);
    res.status(400).json({ error: error.message });
  }
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
  logger.info("Logger Running")
});

module.exports = app;