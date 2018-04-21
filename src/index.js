const express = require('express');
const app = express();
const config = require('./secret/config');

const port = process.env.PORT || 3000;
const env = process.env.NODE_ENV;

app.get('/', (req, res) => {
    res.send(`It works! It\'s ${env}! From github.com ${config.token}`);
});

app.listen(port, () => {
    console.log(`Listening ${port}...`);
});