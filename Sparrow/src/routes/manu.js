var express = require("express");
var router = express.Router();

var manuController = require("../controllers/manuController");

router.get("/buscar/:idEmpresa/:idMaquina/:idDadoMonitorado/:tipoMaquina", function (req, res) {
    manuController.buscarMedidasTempoReal(req, res);
});

module.exports = router;