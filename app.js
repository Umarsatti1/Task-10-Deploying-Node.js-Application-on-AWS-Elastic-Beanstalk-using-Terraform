const express = require('express');
const path = require('path'); 
const app = express();

const port = process.env.PORT || 3000;

app.use(express.static(path.join(__dirname, 'public')));

app.listen(port, () => {
  console.log(`Server is now serving static files from the 'public' folder.`);
  console.log(`Access the application at http://localhost:${port}`);
});

app.get('/health', (req, res) => {
  res.status(200).send('Health status: OK');
});