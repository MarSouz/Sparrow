var database = require("../database/config");

function buscarMedidasTempoReal(idEmpresa, maquina, dado_monitorado, tipoMaquina) {

  var instrucaoSql = `SELECT TIME(dc.data_hora) as horario, dc.*
FROM dado_capturado dc
JOIN maquina m ON dc.fk_maquina = m.id
JOIN tipo_maquina tm ON m.fk_tipo_maquina = tm.id
WHERE dc.fk_empresa = ${idEmpresa}
  AND dc.fk_maquina = ${maquina}
  AND dc.fk_dado_monitorado = ${dado_monitorado}
  AND tm.id = ${tipoMaquina}
ORDER BY dc.data_hora DESC
LIMIT 5;  `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

module.exports = {
  buscarMedidasTempoReal
}