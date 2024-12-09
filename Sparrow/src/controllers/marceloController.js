var marceloModel = require("../models/marceloModel");

function buscarTotalAlertas(req, res) {
  var idEmpresa = req.params.idEmpresa;
  var idMaquina = req.params.idMaquina;
  var idMes = req.params.idMes;

  marceloModel.buscarTotalAlertas(idEmpresa, idMaquina, idMes).then((resultado) => {
    res.status(200).json(resultado);
  });
}

function listarAlertas(req, res) {
  var idEmpresa = req.params.idEmpresa;
  var idMaquina = req.params.idMaquina;
  var idMes = req.params.idMes;

  marceloModel.listarAlertas(idEmpresa, idMaquina, idMes).then((resultado) => {
    res.status(200).json(resultado);
  });
}

function mostrarGraficoAnual(req, res) {
  var idEmpresa = req.params.idEmpresa;
  var idMaquina = req.params.idMaquina;
  var tipoMaquina = req.params.tipoMaquina;
  var idMes = req.params.idMes;

  marceloModel.listarAlertas(idEmpresa, idMaquina, tipoMaquina, idMes).then((resultado) => {
    res.status(200).json(resultado);
  });
}

module.exports = {
  buscarTotalAlertas,
  listarAlertas, 
  mostrarGraficoAnual
}