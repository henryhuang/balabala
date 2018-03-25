const express = require('express');
const app = express();

const port = process.env.PORT || 3000;
const env = process.env.NODE_ENV;

app.get('/', (req, res) => {
    res.send(`It works! It\'s ${env}! From github.com`);
});

app.listen(port, () => {
    console.log(`Listening ${port}...`);
});