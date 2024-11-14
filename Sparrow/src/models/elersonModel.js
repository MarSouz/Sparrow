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
        LIMIT 1) AS dado2
FROM elerson_dados_tratados et
WHERE fk_empresa = ${idEmpresa} 
AND periodo_dias = ${periodo}
GROUP BY fk_maquina, fk_empresa;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarMedidasDispersao
}