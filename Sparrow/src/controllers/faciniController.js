var faciniModel = require("../models/faciniModel");

function buscarMedidasTempoReal(req, res) {
  var idEmpresa = 1
  var idMaquina = 5
  var idDadoMonitorado = req.params.idDadoMonitorado;
  var tipoMaquina = 1

  faciniModel.buscarMedidasTempoReal(idEmpresa, idMaquina, idDadoMonitorado, tipoMaquina).then((resultado) => {
    res.status(200).json(resultado);
  });
}

function buscarPacotesTempoReal(req, res) {
  var idEmpresa = 1
  var idMaquina = 6

  faciniModel.buscarPacotesTempoReal(idEmpresa, idMaquina).then((resultado) => {
    res.status(200).json(resultado);
  });
}

module.exports = {
  buscarMedidasTempoReal,
  buscarPacotesTempoReal
}