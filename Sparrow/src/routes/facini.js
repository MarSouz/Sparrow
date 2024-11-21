var express = require("express");
var router = express.Router();

var faciniController = require("../controllers/faciniController");

router.get("/buscar/:idDadoMonitorado", function (req, res) {
    faciniController.buscarMedidasTempoReal(req, res);
});

router.get("/buscarPacotes", function (req, res) {
    faciniController.buscarPacotesTempoReal(req, res);
});

module.exports = router;