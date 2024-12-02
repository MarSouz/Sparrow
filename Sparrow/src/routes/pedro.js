var express = require('express');
var router = express.Router();
var pedroController = require('../controllers/pedroController');

router.get('/dados-semana/:idEmpresa/:componente/:fkMaquina', function (req, res) {
    pedroController.buscarDadosSemanalController(req, res)
});

router.get('/limite-componente/:idEmpresa/:fkMaquina', function (req, res) {
    pedroController.buscarDadosLimiteController(req, res)
});

router.get('/listarMaquinas/:idEmpresa/:tipoMaquina', function (req, res) {
    pedroController.listar(req, res)
});


module.exports = router;
