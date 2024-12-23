var express = require("express");
var router = express.Router();

var empresaController = require("../controllers/empresaController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrar", function (req, res) {
    empresaController.cadastrar(req, res);
})

router.put("/editar/:idEmpresa", function (req, res) {
  empresaController.editarEmpresa(req, res);
});

router.get("/buscar", function (req, res) {
    empresaController.buscarPorCnpj(req, res);
});

router.get("/buscar/:id", function (req, res) {
  empresaController.buscarPorId(req, res);
});

router.get("/listar", function (req, res) {
  empresaController.listar(req, res);
});

router.post("/cadastrarContato", function (req, res) {
  empresaController.cadastrarContato(req, res);
})

router.delete("/deletar/:idEmpresa", function (req, res) {
  empresaController.deletar(req, res);
});

router.get("/contato", function (req, res) {
  empresaController.contato(req, res);
});

module.exports = router;