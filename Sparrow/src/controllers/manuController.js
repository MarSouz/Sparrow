var manuModel = require("../models/manuModel");

function buscarMedidasTempoReal(req, res) {
  var idEmpresa = req.params.idEmpresa;
  var idMaquina = req.params.idMaquina;
  var idDadoMonitorado = req.params.idDadoMonitorado;
  var tipoMaquina = req.params.tipoMaquina;

  manuModel.buscarMedidasTempoReal(idEmpresa, idMaquina, idDadoMonitorado, tipoMaquina).then((resultado) => {
    res.status(200).json(resultado);
  });
}


function buscarCards(req, res) {
  var idEmpresa = req.params.idEmpresa;
  var idMaquina = req.params.idMaquina;

  manuModel.buscarCards(idEmpresa, idMaquina).then((resultado) => {
    res.status(200).json(resultado);
  });
}


function buscarSelect(req, res) {
  var idEmpresa = req.params.idEmpresa;

  manuModel.buscarSelect(idEmpresa).then((resultado) => {
    res.status(200).json(resultado);
  });
}



function buscarMedidasBarplot(req, res) {
  var idEmpresa = req.params.idEmpresa
  var idMaquina = req.params.idMaquina
  var idDadoMonitorado= req.params.idDadoMonitorado
  manuModel.buscarMedidasBarplot(idEmpresa, idMaquina, idDadoMonitorado).then((resultado) => {
    res.status(200).json(resultado)
  })
}


function buscarMapa(req, res) {
  var idEmpresa = req.params.idEmpresa
  var idMaquina = req.params.idMaquina
  manuModel.buscarMapa(idEmpresa, idMaquina).then((resultado) => {
    res.status(200).json(resultado)
  })
}

function buscarValoresCriticos(req, res) {
  var idEmpresa = req.params.idEmpresa;
  var idMaquina = req.params.idMaquina; // Adicionando o idMaquina
  manuModel.buscarValoresCriticos(idEmpresa, idMaquina).then((resultado) => {
    res.status(200).json(resultado)
  })
}


module.exports = {
  buscarMedidasTempoReal,
  buscarMedidasBarplot,
  buscarMapa,
  buscarCards, 
  buscarSelect,
  buscarValoresCriticos
}