var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:idAquario", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:idAquario", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
})


router.get("/buscar/:idEmpresa/:tipoMaquina", function (req, res) {
    medidaController.buscarMaquina(req, res);
});


router.post("/editar/:idMaquina", function (req, res) {
    medidaController.editarMaquinas(req, res);
});

router.delete("/deletar/:idMaquina", function (req, res) {
    medidaController.deletarMaquina(req, res);
});

// TERMINAIS

// router.get("/buscar/:idEmpresa/:tipoTerminal", function (req, res) {
//     medidaController.buscarMaquina(req, res);
// });


// router.post("/editar/:idMaquinaTerminal", function (req, res) {
//     medidaController.editarMaquinas(req, res);
// });

// router.delete("/deletar/:idMaquinaTerminal", function (req, res) {
//     medidaController.deletarMaquina(req, res);
// });



module.exports = router;