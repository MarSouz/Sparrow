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
LIMIT 10;  `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


function buscarMedidasBarplot(idEmpresa, idMaquina, idDadoMonitorado) {

  var instrucaoSql = `SELECT 
    dm.nome AS componente_nome,
    HOUR(mdt.data_hora) AS hora, 
    COUNT(mdt.id) AS total_alertas
FROM 
    manu_dados_tratados AS mdt
JOIN 
    dado_monitorado AS dm ON mdt.fk_dado_monitorado = dm.id
WHERE 
    mdt.fk_empresa = ${idEmpresa}
    AND mdt.fk_maquina = ${idMaquina}
    AND mdt.fk_dado_monitorado = ${idDadoMonitorado}
GROUP BY 
    dm.nome, 
    HOUR(mdt.data_hora)
ORDER BY 
    hora;`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

module.exports = {
  buscarMedidasTempoReal,
  buscarMedidasBarplot
}