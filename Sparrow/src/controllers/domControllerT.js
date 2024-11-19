var domModelT = require("../models/domModelT");


function qtdTerminal(req, res) {

    var idEmpresa = req.params.ID_EMPRESA;
    
    domModelT.qtdTerminal(idEmpresa).then(function (resultado) {
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

function qtdAlertaAtualT(req, res) {

    var idEmpresa = req.params.ID_EMPRESA;
    
    domModelT.qtdAlertaAtualT(idEmpresa).then(function (resultado) {
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

function qtdAlertaPassadoT(req, res) {

    var idEmpresa = req.params.ID_EMPRESA;
    
    domModelT.qtdAlertaPassadoT(idEmpresa).then(function (resultado) {
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
    qtdTerminal,
    qtdAlertaAtualT,
    qtdAlertaPassadoT
}