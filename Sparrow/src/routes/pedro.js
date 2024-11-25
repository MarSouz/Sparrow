var express = require('express');
var router = express.Router();
var pedroController = require('../controllers/pedroController');

router.get('/dados-semana/:idEmpresa/:tipoMaquina/:componente', function (req, res) {
    pedroController.buscarDadosSemanalController(req, res)

    var idEmpresa = req.params.idEmpresa;
    var tipoMaquina = req.params.tipoMaquina;
    var componente = req.params.componente;

});

router.get('/limite-componente/:componente', function (req, res) {
    pedroController.buscarDadosLimiteController(req, res)
});

router.get('/listarMaquinas/:idEmpresa/:tipoMaquina', function (req, res) {
    pedroController.listar(req, res)
});


module.exports = router;
