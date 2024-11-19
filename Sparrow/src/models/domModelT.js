var database = require("../database/config");

function qtdTerminal(idEmpresa) {
    
    var instrucaoSql = `SELECT COUNT(*) FROM maquina WHERE fk_empresa = ${idEmpresa} and fk_tipo_maquina = 1;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);

}

function qtdAlertaAtualT(idEmpresa) {
    
    var instrucaoSql = `SELECT COUNT(*) FROM alerta AS a
	JOIN dado_capturado AS dc
    ON a.fk_dado_maquina = dc.id
    JOIN maquina AS m
    ON m.id = dc.fk_maquina
    WHERE m.fk_empresa = ${idEmpresa}
    AND m.fk_tipo_maquina = 1
    AND YEARWEEK(data_hora, 1) = YEARWEEK(CURDATE(), 1);`;
    

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);

}

function qtdAlertaPassadoT(idEmpresa) {
    
    var instrucaoSql = `SELECT COUNT(*) FROM alerta AS a
	JOIN dado_capturado AS dc
    ON a.fk_dado_maquina = dc.id
    JOIN maquina AS m
    ON m.id = dc.fk_maquina
    WHERE m.fk_empresa = ${idEmpresa}
    AND m.fk_tipo_maquina = 1
    AND YEARWEEK(data_hora, 1) = YEARWEEK(CURDATE(), 1) - 1;`;
    

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);

}


module.exports = {
    qtdTerminal,
    qtdAlertaAtualT,
    qtdAlertaPassadoT
}