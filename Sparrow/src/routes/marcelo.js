var express = require("express");
var router = express.Router();

var marceloController = require("../controllers/marceloController");

router.get("/buscar/:idEmpresa/:idMaquina/:tipoMaquina/:idMes", function (req, res) {
    marceloController.buscarTotalAlertas(req, res);
});


module.exports = router;