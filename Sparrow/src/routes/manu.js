var express = require("express");
var router = express.Router();

var manuController = require("../controllers/manuController");

router.get("/buscar/:idEmpresa/:idMaquina/:idDadoMonitorado/:tipoMaquina", function (req, res) {
    manuController.buscarMedidasTempoReal(req, res);
});

router.get("/buscarCards/:idEmpresa/:idMaquina", function (req, res) {
    manuController.buscarCards(req, res);
});

router.get("/buscarSelect/:idEmpresa/:tipoMaquina", function (req, res) {
    manuController.buscarSelect(req, res);
});

router.get("/buscarBarplot/:idEmpresa/:idMaquina/:idDadoMonitorado", function(req,res){
    manuController.buscarMedidasBarplot(req,res)
})

router.get("/buscarMapa/:idEmpresa/:idMaquina", function(req,res){
    manuController.buscarMapa(req,res)
})

router.get("/buscarValoresCriticos/:idEmpresa/:idMaquina", function (req, res) {
    manuController.buscarValoresCriticos(req, res);
});

module.exports = router;