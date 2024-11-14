var express = require("express");
var router = express.Router();

var elersonController = require("../controllers/elersonController");

router.get("/buscar/:idEmpresa/:periodo/:dado1/:dado2", function (req, res) {
    elersonController.buscarMedidasDispersao(req, res);
});

module.exports = router;