var database = require("../database/config");

function buscarMedidasTempoReal(idEmpresa, dado_monitorado, tipoMaquina) {

    var instrucaoSql = `SELECT TIME(dc.data_hora) as horario, dc.*
  FROM dado_capturado dc
  JOIN maquina m ON dc.fk_maquina = m.id
  JOIN tipo_maquina tm ON m.fk_tipo_maquina = tm.id
  JOIN maquina_dado_monitorado mdm ON mdm.fk_maquina = dc.fk_maquina
  WHERE dc.fk_empresa = ${idEmpresa}
    AND dc.fk_dado_monitorado = ${dado_monitorado}
    AND tm.id = ${tipoMaquina}
    AND m.endereco_mac = "12:74:bc:ab:43:1d"
  ORDER BY dc.data_hora DESC
  LIMIT 20;`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarPacotesTempoReal(idEmpresa) {

  var instrucaoSql = `SELECT TIME(dc.data_hora) as horario, dc.*
  FROM dado_capturado dc
  JOIN maquina m ON dc.fk_maquina = m.id
  WHERE dc.fk_empresa = ${idEmpresa}
    AND m.endereco_mac = "12:74:bc:ab:43:1d"
    AND (dc.fk_dado_monitorado = 4 OR dc.fk_dado_monitorado = 5)
  ORDER BY dc.data_hora DESC
  LIMIT 10;`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function estadoComponentes(idEmpresa, dado_monitorado) {

  var instrucaoSql = `SELECT CASE WHEN COUNT(*) >= 15 
	THEN 1 ELSE 0 END AS situacao_critica FROM (
		SELECT registro FROM dado_capturado dc
        JOIN maquina m ON dc.fk_maquina = m.id
		WHERE m.fk_empresa = ${idEmpresa}
    AND m.endereco_mac = "12:74:bc:ab:43:1d"
    AND fk_dado_monitorado = ${dado_monitorado}
		ORDER BY data_hora DESC
		LIMIT 50
	) AS ultimos_dados
	WHERE registro >= 80;`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

module.exports = {
  buscarMedidasTempoReal,
  buscarPacotesTempoReal,
  estadoComponentes
}