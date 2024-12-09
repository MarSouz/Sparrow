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

function buscarCards(idEmpresa, idMaquina) {

  var instrucaoSql = `SELECT 
(select registro from dado_capturado where fk_empresa= ${idEmpresa} and fk_maquina = ${idMaquina} and fk_dado_monitorado = 1 order by id desc limit 1) AS cpu,
(select registro from dado_capturado where fk_empresa= ${idEmpresa} and fk_maquina = ${idMaquina} and fk_dado_monitorado =  2 order by id desc limit 1) AS ram,
(select registro from dado_capturado where fk_empresa= ${idEmpresa} and fk_maquina = ${idMaquina} and fk_dado_monitorado = 3 order by id desc  limit 1) AS disco,
(select registro from dado_capturado where fk_empresa= ${idEmpresa} and fk_maquina = ${idMaquina} and fk_dado_monitorado = 4 order by id desc  limit 1) AS pacotes_enviados,
(select registro from dado_capturado where fk_empresa= ${idEmpresa} and fk_maquina = ${idMaquina} and fk_dado_monitorado = 5 order by id desc limit 1) AS pacotes_recebidos;`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarMedidasBarplot(idEmpresa, idMaquina, idDadoMonitorado) {

  var instrucaoSql = `SELECT 
    dm.nome AS componente_nome,
    HOUR(mdt.data_hora) AS hora, 
    MAX(mdt.registro) AS pico_maximo
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



function buscarSelect(idEmpresa, tipoMaquina) {

  var instrucaoSql = `select id from maquina where fk_empresa = ${idEmpresa} and fk_tipo_maquina = ${tipoMaquina};`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


function buscarMapa(idEmpresa, idMaquina) {

  var instrucaoSql = `SELECT 
    m.id AS id_maquina,
    m.fk_empresa AS id_empresa,
    c.latitude AS lat,
    c.longitude AS lon
FROM 
    Sparrow.maquina m
LEFT JOIN 
    Sparrow.coordenada c ON c.id = m.fk_coordenada
WHERE 
    m.fk_empresa = ${idEmpresa}
AND 
	m.id = ${idMaquina};`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


function buscarValoresCriticos(idEmpresa, idMaquina) {
  var instrucaoSql = `SELECT 
    mdm.fk_maquina,
    dm.nome AS dado_monitorado_nome,
    mdm.limite_componente AS valor_critico,
    m.endereco_mac,
    m.id AS id_maquina
FROM 
    maquina_dado_monitorado mdm
JOIN 
    dado_monitorado dm ON mdm.fk_dado_monitorado = dm.id
JOIN 
    maquina m ON mdm.fk_maquina = m.id
WHERE 
    mdm.fk_empresa = ${idEmpresa}
    AND m.id = ${idMaquina}`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarMedidasTempoReal,
  buscarCards,
  buscarMedidasBarplot, 
  buscarMapa,
  buscarSelect,
  buscarValoresCriticos
}