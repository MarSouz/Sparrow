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



function buscarMedidasBarplot(req, res) {
  var idEmpresa = req.params.idEmpresa
  var idMaquina = req.params.idMaquina
  var idDadoMonitorado= req.params.idDadoMonitorado
  manuModel.buscarMedidasBarplot(idEmpresa, idMaquina, idDadoMonitorado).then((resultado) => {
    res.status(200).json(resultado)
  })
}

module.exports = {
  buscarMedidasTempoReal,
  buscarMedidasBarplot
}