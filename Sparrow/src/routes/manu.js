var express = require("express");
var router = express.Router();

var manuController = require("../controllers/manuController");

router.get("/buscar/:idEmpresa/:idMaquina/:idDadoMonitorado/:tipoMaquina", function (req, res) {
    manuController.buscarMedidasTempoReal(req, res);
});

router.get("/buscarBarplot/:idEmpresa/:idMaquina/:idDadoMonitorado", function(req,res){
    manuController.buscarMedidasBarplot(req,res)
})

module.exports = router;