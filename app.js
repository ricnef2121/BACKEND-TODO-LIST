require("dotenv").config();
const express = require("express");
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

const db = [{
  name: "juan",
  description: "sdddes",
}]

// Create
app.post("/items", async (req, res) => {
  try {
    console.log({body:req.body})
    db.push(req.body)
    // const newItem = new Item(req.body);
    // const savedItem = await newItem.save();
    res.status(201).json(req.body);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Read
app.get("/items", async (req, res) => {
  try {
    // const items = await Item.find();
    res.json(db);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Update
app.put("/items/:id", async (req, res) => {
  try {
    // const updatedItem = await Item.findByIdAndUpdate(req.params.id, req.body, {
    //   new: true,
    // });
    res.json(req.body);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Delete
// app.delete("/items/:id", async (req, res) => {
//   try {
//     const deletedItem = await Item.findByIdAndDelete(req.params.id);
//     res.json(deletedItem);
//   } catch (error) {
//     res.status(400).json({ error: error.message });
//   }
// });

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

module.exports = app;