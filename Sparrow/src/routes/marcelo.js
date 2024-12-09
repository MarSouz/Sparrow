var express = require("express");
var router = express.Router();

var marceloController = require("../controllers/marceloController");

router.get("/buscar/:idEmpresa/:idMaquina/:idMes", function (req, res) {
    marceloController.buscarTotalAlertas(req, res);
});

router.get("/listar/:idEmpresa/:idMaquina/:idMes", function (req, res) {
    marceloController.listarAlertas(req, res);
});

router.get("/mostrar/:idEmpresa/:idMaquina/:tipoMaquina/:idMes", function (req, res) {
    marceloController.mostrarGraficoAnual(req, res);
});

module.exports = router;