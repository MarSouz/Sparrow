var database = require("../database/config");

function buscarMedidasDispersao(idEmpresa, periodo, idDado1, idDado2) {

    var instrucaoSql = `SELECT fk_maquina,
       fk_empresa,
       (SELECT media 
        FROM elerson_dados_tratados 
        WHERE fk_maquina = et.fk_maquina 
          AND fk_dado_monitorado = ${idDado1} 
        ORDER BY id DESC 
        LIMIT 1) AS dado1,
       (SELECT media 
        FROM elerson_dados_tratados 
        WHERE fk_maquina = et.fk_maquina 
          AND fk_dado_monitorado = ${idDado2} 
        ORDER BY id DESC 
        LIMIT 1) AS dado2,
        (SELECT desvio_padrao 
        FROM elerson_dados_tratados 
        WHERE fk_maquina = et.fk_maquina 
          AND fk_dado_monitorado = ${idDado1} 
        ORDER BY id DESC 
        LIMIT 1) AS desvio1,
        (SELECT desvio_padrao
        FROM elerson_dados_tratados 
        WHERE fk_maquina = et.fk_maquina 
          AND fk_dado_monitorado = ${idDado2} 
        ORDER BY id DESC 
        LIMIT 1) AS desvio2
FROM elerson_dados_tratados et
WHERE fk_empresa = ${idEmpresa} 
AND periodo_dias = ${periodo}
GROUP BY fk_maquina, fk_empresa;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasBoxplot(idEmpresa, idMaquina, periodo, idDado1, idDado2) {

  var instrucaoSql = `SELECT 
    fk_maquina,
    fk_empresa,
    fk_dado_monitorado,
    minimo,
    primeiro_quartil,
    mediana,
    terceiro_quartil,
    maximo,
    outliers
FROM elerson_dados_tratados
WHERE id IN (
    SELECT MAX(id)
    FROM elerson_dados_tratados
    WHERE fk_empresa = ${idEmpresa} 
      AND periodo_dias = ${periodo}
      AND fk_maquina = ${idMaquina}
      AND fk_dado_monitorado IN (${idDado1}, ${idDado2})
    GROUP BY fk_dado_monitorado
);`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

module.exports = {
    buscarMedidasDispersao,
    buscarMedidasBoxplot
}