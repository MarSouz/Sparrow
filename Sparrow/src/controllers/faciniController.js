var faciniModel = require("../models/faciniModel");

function buscarMedidasTempoReal(req, res) {
  var idEmpresa = 1
  var idDadoMonitorado = req.params.idDadoMonitorado;
  var tipoMaquina = 1

  faciniModel.buscarMedidasTempoReal(idEmpresa, idDadoMonitorado, tipoMaquina).then((resultado) => {
    res.status(200).json(resultado);
  });
}

function buscarPacotesTempoReal(req, res) {
  var idEmpresa = 1

  faciniModel.buscarPacotesTempoReal(idEmpresa).then((resultado) => {
    res.status(200).json(resultado);
  });
}

async function estadoComponentes(req, res) {
  var idEmpresa = 1

  var res1 = await faciniModel.estadoComponentes(idEmpresa, 1);
  var res2 = await faciniModel.estadoComponentes(idEmpresa, 2);
  var res3 = await faciniModel.estadoComponentes(idEmpresa, 3);

  console.log(res1);
  console.log(res2);
  console.log(res3);
  

  var resultado = {
    cpu_situacao_critica: res1[0].situacao_critica,
    ram_situacao_critica: res2[0].situacao_critica,
    disco_situacao_critica: res3[0].situacao_critica
  }

  console.log("componentes", resultado);
  

  res.status(200).json(resultado)
}

module.exports = {
  buscarMedidasTempoReal,
  buscarPacotesTempoReal,
  estadoComponentes
}