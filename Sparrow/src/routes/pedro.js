var express = require('express');
var router = express.Router();
var pedroController = require('../controllers/pedroController');

router.get('/dados-semana/:componente', function (req, res) {
    pedroController.buscarDadosSemanalController(req, res)
});


module.exports = router;
