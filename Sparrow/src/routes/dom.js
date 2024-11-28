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


router.get("/histCpuS/:ID_EMPRESA", function (req, res) {
    domControllerS.histCpuS(req, res);
});
router.get("/histCpuT/:ID_EMPRESA", function (req, res) {
    domControllerT.histCpuT(req, res);
});


router.get("/histRamS/:ID_EMPRESA", function (req, res) {
    domControllerS.histRamS(req, res);
});
router.get("/histRamT/:ID_EMPRESA", function (req, res) {
    domControllerT.histRamT(req, res);
});


router.get("/histDiscoS/:ID_EMPRESA", function (req, res) {
    domControllerS.histDiscoS(req, res);
});
router.get("/histDiscoT/:ID_EMPRESA", function (req, res) {
    domControllerT.histDiscoT(req, res);
});


router.get("/treemapS/:ID_EMPRESA", function (req, res) {
    domControllerS.treemapS(req, res);
});
router.get("/treemapT/:ID_EMPRESA", function (req, res) {
    domControllerT.treemapT(req, res);
});


router.get("/regressaoServidor/:ID_EMPRESA", function (req, res) {
    domControllerS.regressaoServidor(req, res);
});
router.get("/regressaoTerminal/:ID_EMPRESA", function (req, res) {
    domControllerT.regressaoTerminal(req, res);
});

module.exports = router;