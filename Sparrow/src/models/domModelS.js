var database = require("../database/config");

function qtdServidor(idEmpresa) {
    
    var instrucaoSql = `SELECT COUNT(*) FROM maquina WHERE fk_empresa = ${idEmpresa} and fk_tipo_maquina = 2;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);

}

function qtdAlertaAtualS(idEmpresa) {
    
    var instrucaoSql = `SELECT COUNT(*) FROM alerta AS a
	JOIN dado_capturado AS dc
    ON a.fk_dado_maquina = dc.id
    JOIN maquina AS m
    ON m.id = dc.fk_maquina
    WHERE m.fk_empresa = ${idEmpresa}
    AND m.fk_tipo_maquina = 2
    AND YEARWEEK(data_hora, 1) = YEARWEEK(CURDATE(), 1);`;
    

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);

}

function qtdAlertaPassadoS(idEmpresa) {
    
    var instrucaoSql = `SELECT COUNT(*) FROM alerta AS a
	JOIN dado_capturado AS dc
    ON a.fk_dado_maquina = dc.id
    JOIN maquina AS m
    ON m.id = dc.fk_maquina
    WHERE m.fk_empresa = ${idEmpresa}
    AND m.fk_tipo_maquina = 2
    AND YEARWEEK(data_hora, 1) = YEARWEEK(CURDATE(), 1) - 1;`;
    

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);

}


module.exports = {
    qtdServidor,
    qtdAlertaAtualS,
    qtdAlertaPassadoS
}
