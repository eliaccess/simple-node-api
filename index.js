const express = require('express');
const app = express();
const port = 3000;

app.get('/test', (req, res) => {
  res.send('Hello from test route!');
});

app.listen(port, () => {
  console.log(`App running on http://localhost:${port}`);
});

