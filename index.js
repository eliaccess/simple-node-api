const express = require('express');
const app = express();
const port = 3000;

app.get('/test', (req, res) => {
  res.send('Hello from test route! This is the v2.');
});

app.get('/new', (req, res) => {
  res.send('This is a new route.');
});

app.listen(port, () => {
  console.log(`App running on http://localhost:${port}`);
});

