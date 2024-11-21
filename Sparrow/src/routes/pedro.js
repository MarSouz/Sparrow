const express = require('express');
const router = express.Router();
const pedroController = require('../controllers/pedroController');

router.get('/dados-semana/:componente', pedroController.buscarDadosSemanalController);

module.exports = router;
