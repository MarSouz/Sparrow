var medidaModel = require("../models/medidaModel");

function buscarMaquina(req, res) {

    var idEmpresa = req.params.idEmpresa;
    var tipoMaquina = req.params.tipoMaquina;

    medidaModel.buscarMaquina(idEmpresa, tipoMaquina).then(function (resultado) {
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


function editarMaquinas(req, res) {
    var idMaquina = req.params.idMaquina
    var idEmpresa = req.params.idEmpresa
    var longitude = req.body.longitudeServer
    var latitude = req.body.latitudeServer
    var limiteCPU = req.body.limiteCPUServer
    var limiteRam = req.body.limiteRamServer
    var limiteDisco = req.body.limiteDiscoServer
    var idlocalizacao = req.body.idLocalizacaoServer


    if (idlocalizacao != null) {
        medidaModel.atualizarLocalizacao(latitude, longitude, idlocalizacao)
        medidaModel.editarMaquinas(idMaquina, idEmpresa, idlocalizacao, limiteCPU, limiteRam, limiteDisco).then(function (resultado) {
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
    else {
        if (latitude != null && longitude != null) {
            medidaModel.inserirLocalizacao(latitude, longitude)
            medidaModel.buscarLocalizacao(latitude, longitude).then(function (resultado) {
                idlocalizacao = resultado[0].id
                medidaModel.atribuirLocalizacao(idlocalizacao, idMaquina, idEmpresa)
            })
        }
        medidaModel.editarMaquinas(idMaquina, idEmpresa, limiteCPU, limiteRam, limiteDisco).then(function (resultado) {
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

    console.log(`Editando informações!`);
}

function deletarMaquina(req, res) {

    var idEmpresa = req.params.idEmpresa;

    var idMaquina = req.params.idMaquina;

    console.log(`Deletando máquina!`);

    medidaModel.deletarMaquina(idMaquina, idEmpresa).then(function (resultado) {
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
    buscarMaquina,
    editarMaquinas,
    deletarMaquina
}