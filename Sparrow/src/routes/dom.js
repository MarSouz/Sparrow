var express = require("express");
var router = express.Router();

var domControllerT = require("../controllers/domControllerT");
var domControllerS = require("../controllers/domControllerS");

router.get("/qtdServidor/:ID_EMPRESA", function (req, res) {
    domControllerS.qtdServidor(req, res);
});
router.get("/qtdTerminal/:ID_EMPRESA", function (req, res) {
    domControllerT.qtdTerminal(req, res);
});


router.get("/qtdAlertaAtualS/:ID_EMPRESA", function (req, res) {
    domControllerS.qtdAlertaAtualS(req, res);
});
router.get("/qtdAlertaAtualT/:ID_EMPRESA", function (req, res) {
    domControllerT.qtdAlertaAtualT(req, res);
});


router.get("/qtdAlertaPassadoS/:ID_EMPRESA", function (req, res) {
    domControllerS.qtdAlertaPassadoS(req, res);
});
router.get("/qtdAlertaPassadoT/:ID_EMPRESA", function (req, res) {
    domControllerT.qtdAlertaPassadoT(req, res);
});


router.get("/histComponenteS/:ID_EMPRESA", function (req, res) {
    domControllerS.histComponenteS(req, res);
});
router.get("/histComponenteT/:ID_EMPRESA", function (req, res) {
    domControllerT.histComponenteT(req, res);
});


router.get("/histTotalS/:ID_EMPRESA", function (req, res) {
    domControllerS.histTotalS(req, res);
});
router.get("/histTotalT/:ID_EMPRESA", function (req, res) {
    domControllerT.histTotalT(req, res);
});


router.get("/regressaoServidor/:ID_EMPRESA", function (req, res) {
    domControllerS.regressaoServidor(req, res);
});
router.get("/regressaoTerminal/:ID_EMPRESA", function (req, res) {
    domControllerT.regressaoTerminal(req, res);
});

module.exports = router;