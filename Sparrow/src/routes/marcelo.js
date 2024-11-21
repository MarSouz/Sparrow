var express = require("express");
var router = express.Router();

var emarceloController = require("../controllers/marceloController");

router.get("/buscar/:idEmpresa/:tipoMaquina/:nomeComponente/:totalAlertas", function (req, res) {
    marceloController.buscarMedidasDispersao(req, res);
});


module.exports = router;