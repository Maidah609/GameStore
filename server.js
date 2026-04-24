const express = require('express');
const sql = require('mssql/msnodesqlv8');
const bodyParser = require('body-parser');
const cors = require('cors');
const authRoutes = require("./routes/auth");
const path = require("path");
const gameRoutes = require("./routes/game");
const adminRoutes = require("./routes/admin");

const app = express();
const PORT = 5000;
app.use(cors());
app.use(bodyParser.json());

app.use("/api", authRoutes);
app.use("/api", gameRoutes);
app.use("/api", adminRoutes);
app.use(express.static("public"));


app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "pages", "login.html"));
});
app.get("/register.html", (req, res) => {
  res.sendFile(path.join(__dirname, "pages", "register.html"));
});
app.get("/home.html", (req, res) => {
  res.sendFile(path.join(__dirname, "pages", "home.html"));
});
app.get("/cart.html", (req, res) => {
  res.sendFile(path.join(__dirname, "pages", "cart.html"));
});
app.get("/order.html", (req, res) => {
  res.sendFile(path.join(__dirname, "pages", "order.html"));
});
app.get("/payment.html", (req, res) => {
  res.sendFile(path.join(__dirname, "pages", "payment.html"));
});
app.get("/summary.html", (req, res) => {
  res.sendFile(path.join(__dirname, "pages", "summary.html"));
});
app.get("/edit.html", (req, res) => {
  res.sendFile(path.join(__dirname, "pages", "edit.html"));
});
app.get("/add.html", (req, res) => {
  res.sendFile(path.join(__dirname, "pages", "add.html"));
});



app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});