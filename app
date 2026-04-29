import express from "express";
import cors from "cors";
import bodyParser from "body-parser";
import jwt from "jsonwebtoken";

const app = express();
app.use(cors());
app.use(bodyParser.json());

const SECRET = "supersecret";

// Demo users
let users = [
  { email: "admin@school.local", password: "admin123", role: "admin" }
];

let devices = [];
let alerts = [];

/* LOGIN */
app.post("/login", (req, res) => {
  const { email, password } = req.body;
  const user = users.find(u => u.email === email && u.password === password);

  if (!user) return res.status(401).send("Invalid login");

  const token = jwt.sign({ email: user.email }, SECRET);
  res.json({ token });
});

/* INVITE USER */
app.post("/invite", (req, res) => {
  users.push({ email: req.body.email, role: "user" });
  res.send("User invited");
});

/* REGISTER DEVICE */
app.post("/enrol", (req, res) => {
  devices.push({
    user: req.body.user,
    device: req.body.device
  });
  res.send("Device enrolled");
});

/* BLOCK EVENT */
app.post("/block", (req, res) => {
  alerts.push(req.body);
  res.send("Blocked logged");
});

/* REPORTS */
app.get("/reports", (req, res) => {
  res.json(alerts);
});

app.listen(4000, () => console.log("Backend running on port 4000"));
``
