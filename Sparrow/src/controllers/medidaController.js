var medidaModel = require("../models/medidaModel");

function buscarUltimasMedidas(req, res) {

    // const limite_linhas = 7;

    var idAquario = req.params.idAquario;

    // console.log(`Recuperando as ultimas ${limite_linhas} medidas`);

    medidaModel.buscarUltimasMedidas(idAquario).then(function (resultado) {
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
    var idMaquina = req.params.idMaquina;
    var longitude = req.body.longitudeServer
    var latitude = req.body.latitudeServer
    var limiteCPU = req.body.limiteCPUServer
    var limiteRam = req.body.limiteRamServer
    var limiteDisco = req.body.limiteDiscoServer

    console.log(`Editando informações!`);

    medidaModel.editarMaquinas(idMaquina, longitude, latitude, limiteCPU, limiteRam, limiteDisco).then(function (resultado) {
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

function deletarMaquina(req, res) {

    var idMaquina = req.params.idMaquina;

    console.log(`Deletando máquina!`);

    medidaModel.deletarMaquina(idMaquina).then(function (resultado) {
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



// TERMINAL


// function editarMaquinaTerminal(req, res) {

//     var idMaquinaTerminal = req.params.idMaquinaTerminal;
//     var longitude = req.body.longitudeServer
//     var latitude = req.body.latitudeServer
//     var limiteCPU = req.body.limiteCPUServer
//     var limiteRam = req.body.limiteRamServer
//     var limiteDisco = req.body.limiteDiscoServer

//     console.log(`Editando informações!`);

//     medidaModel.editarMaquinas(idMaquinaTerminal, longitude, latitude, limiteCPU, limiteRam, limiteDisco).then(function (resultado) {
//         if (resultado.length > 0) {
//             res.status(200).json(resultado);
//         } else {
//             res.status(204).send("Nenhum resultado encontrado!")
//         }
//     }).catch(function (erro) {
//         console.log(erro);
//         console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
//         res.status(500).json(erro.sqlMessage);
//     });
// }


// function deletarMaquinaTerminal(req, res) {

//     var idMaquinaTerminal = req.params.idMaquinaTerminal;

//     console.log(`Deletando máquina!`);

//     medidaModel.deletarMaquina(idMaquinaTerminal).then(function (resultado) {
//         if (resultado.length > 0) {
//             res.status(200).json(resultado);
//         } else {
//             res.status(204).send("Nenhum resultado encontrado!")
//         }
//     }).catch(function (erro) {
//         console.log(erro);
//         console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
//         res.status(500).json(erro.sqlMessage);
//     });
// }


module.exports = {
    buscarUltimasMedidas,
    buscarMaquina,
    editarMaquinas,
    deletarMaquina

    // buscarMaquinaTerminal,
    // editarMaquinaTerminal, 
    // deletarMaquinaTerminal
}