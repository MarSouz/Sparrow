var pedroModel = require('../models/pedroModel');

function buscarDadosSemanalController (req, res) {
    const componente = req.params.componente; // Pegando o componente da URL ou do corpo da requisição
    const idEmpresa = req.params.idEmpresa;

    const idMaquina = req.params.fkMaquina

    pedroModel.buscarDadosSemanal(componente, idEmpresa, idMaquina).then((resultado) => {
        res.status(200).json(resultado);
      });
};

function buscarDadosLimiteController (req, res) { // Pegando o componente da URL ou do corpo da requisição
    const idMaquina = req.params.fkMaquina
    const idEmpresa = req.params.idEmpresa;
    pedroModel.buscarDadosLimiteSemanal(idEmpresa,idMaquina).then((resultado) => {
        res.status(200).json(resultado);
      });
};

function listar(req, res) {

    var idEmpresa = req.params.idEmpresa;
    var tipoMaquina = req.params.tipoMaquina;

    pedroModel.listar(idEmpresa, tipoMaquina).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
    buscarDadosSemanalController,
    buscarDadosLimiteController,
    listar
};
