var marceloModel = require("../models/marceloModel");

function buscarTotalAlertas(req, res) {
    var idEmpresa = req.params.idEmpresa;
    var idMaquina = req.params.idMaquina;
    var tipoMaquina = req.params.tipoMaquina;
    var idMes = req.params.idMes;
  
    marceloModel.buscarTotalAlertas(idEmpresa, idMaquina, tipoMaquina, idMes).then((resultado) => {
      res.status(200).json(resultado);
    });
  }

module.exports = {
  buscarTotalAlertas
}