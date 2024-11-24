var pedroModel = require('../models/pedroModel');

function buscarDadosSemanalController (req, res) {
    const componente = req.params.componente; // Pegando o componente da URL ou do corpo da requisição

    pedroModel.buscarDadosSemanal(componente).then((resultado) => {
        res.status(200).json(resultado);
      });
};

function buscarDadosLimiteController (req, res) {
    const componente = req.params.componente; // Pegando o componente da URL ou do corpo da requisição

    pedroModel.buscarDadosLimiteSemanal(componente).then((resultado) => {
        res.status(200).json(resultado);
      });
};

module.exports = {
    buscarDadosSemanalController,
    buscarDadosLimiteController
};
