var elersonModel = require("../models/elersonModel");

function buscarTotalAlertas(req, res) {
    var idEmpresa = req.params.idEmpresa;
    var tipoMaquina = req.params.periodo;
    var nomeComponente = req.params.dado1;
    var totalAlertas = req.params.dado2;
  
    marceloModel.buscarTotalAlertas(idEmpresa, TipoMaquina, NomeComponente, TotalAlertas).then((resultado) => {
      res.status(200).json(resultado);
    });
  }

module.exports = {
  buscarTotalAlertas
}