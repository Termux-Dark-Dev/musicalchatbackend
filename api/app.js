const express = require("express");
const bodyParser = require("body-parser");
const morgan = require("morgan");
const path = require("path");

const userRoutes = require("../api/routes/user");

const app = express();

app.use(morgan("dev"));

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.get("/uploads/profile_pic/:filename", function (req, res) {
  res.sendFile(
    path.join(__dirname, "../uploads/profile_pic", req.params.filename)
  );
});

app.use("/user", userRoutes);

app.use("*", (req, res, next) => {
  res.status(404).json({
    message: "Resource not found",
  });
});

app.use((error, req, res, next) => {
  console.log("here")
  res.status(error.status || 500).json({
    message: error.message,
  });
  console.log(error.stack);
});

module.exports = app;
