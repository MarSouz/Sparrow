const pedroModel = require('../models/pedroModel');

const buscarDadosSemanalController = (req, res) => {
    const { componente } = req.params; // Pegando o componente da URL ou do corpo da requisição

    pedroModel.buscarDadosSemanal(componente)
        .then(dados => {
            res.status(200).json(dados); // Retorna os dados para o frontend
        })
        .catch(erro => {
            console.error("Erro ao buscar dados semanais: ", erro);
            res.status(500).json({ mensagem: "Erro interno ao buscar dados." });
        });
};

module.exports = {
    buscarDadosSemanalController
};
