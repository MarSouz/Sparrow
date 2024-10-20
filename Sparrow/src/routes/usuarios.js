var express = require("express");
var router = express.Router();

var usuarioController = require("../controllers/usuarioController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrar", function (req, res) {
    usuarioController.cadastrar(req, res);
})

router.post("/autenticar", function (req, res) {
    usuarioController.autenticar(req, res);
});

router.put("/editar/:idFuncionario", function (req, res) {
    usuarioController.editarFuncionario(req, res);
});

router.get("/verificar/:email", function (req, res) {
    usuarioController.verificarEmail(req, res);
});

router.put("/trocar/:idFuncionario", function (req, res) {
    usuarioController.trocarSenha(req, res);
});

router.post("/cadastrar", function (req, res) {
    usuarioController.cadastrar(req, res);
});

module.exports = router;