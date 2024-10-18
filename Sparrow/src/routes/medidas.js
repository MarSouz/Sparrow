var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:idAquario", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:idAquario", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
})

//
router.get("/buscar/:idEmpresa/:tipoMaquina", function (req, res) {
    medidaController.buscarMaquina(req, res);
});


//EDITAR MÁQUINAS
router.get("/ultimas/:idMaquina", function (req, res) {
    medidaController.buscarMaquina(req, res);
});




module.exports = router;