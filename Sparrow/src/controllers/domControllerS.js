var domModelS = require("../models/domModelS");


function qtdServidor(req, res) {

    var idEmpresa = req.params.ID_EMPRESA;
    
    domModelS.qtdServidor(idEmpresa).then(function (resultado) {
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

function qtdAlertaAtualS(req, res) {

    var idEmpresa = req.params.ID_EMPRESA;
    
    domModelS.qtdAlertaAtualS(idEmpresa).then(function (resultado) {
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

function qtdAlertaPassadoS(req, res) {

    var idEmpresa = req.params.ID_EMPRESA;
    
    domModelS.qtdAlertaPassadoS(idEmpresa).then(function (resultado) {
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
    qtdServidor,
    qtdAlertaAtualS,
    qtdAlertaPassadoS
}