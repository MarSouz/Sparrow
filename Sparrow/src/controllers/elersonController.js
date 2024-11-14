var elersonModel = require("../models/elersonModel");

function buscarMedidasDispersao(req, res) {
    var idEmpresa = req.params.idEmpresa;
    var idPeriodo = req.params.periodo;
    var idDado1 = req.params.dado1;
    var idDado2 = req.params.dado2;
  
    elersonModel.buscarMedidasDispersao(idEmpresa, idPeriodo, idDado1, idDado2).then((resultado) => {
      res.status(200).json(resultado);
    });
  }

module.exports = {
    buscarMedidasDispersao
}