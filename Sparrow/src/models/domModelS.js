var database = require("../database/config");

function qtdServidor(idEmpresa) {

    var instrucaoSql = `SELECT * FROM maquina WHERE fk_empresa = ${idEmpresa} and fk_tipo_maquina = 2;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);

}

function qtdAlertaAtualS(idEmpresa) {

    var instrucaoSql = `SELECT * FROM alerta AS a
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

    var instrucaoSql = `SELECT * FROM alerta AS a
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

// dado_monitorado = 1,2,3 || CPU, RAM, Disco
// tipo_maquina = 1,2 || Servidor, Terminal
function histCpuS(idEmpresa) {

    var instrucaoSql = `select * from alerta as a
	join dado_capturado as dc
		on a.fk_dado_maquina = dc.id
	join maquina_dado_monitorado as mdm
		on mdm.fk_maquina = dc.fk_maquina
	join maquina as m
		on mdm.fk_maquina = m.id
	where dc.fk_empresa = ${idEmpresa}
    AND WEEK(dc.data_hora) = WEEK(CURRENT_DATE) 
	and dc.fk_dado_monitorado = 1
    and m.fk_tipo_maquina = 1;`;


    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);

}

function histRamS(idEmpresa) {

    var instrucaoSql = `select * from alerta as a
	join dado_capturado as dc
		on a.fk_dado_maquina = dc.id
	join maquina_dado_monitorado as mdm
		on mdm.fk_maquina = dc.fk_maquina
	join maquina as m
		on mdm.fk_maquina = m.id
	where dc.fk_empresa = ${idEmpresa}
    AND WEEK(dc.data_hora) = WEEK(CURRENT_DATE) 
	and dc.fk_dado_monitorado = 2
    and m.fk_tipo_maquina = 1;`;


    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);

}

function histDiscoS(idEmpresa) {

    var instrucaoSql = `select * from alerta as a
	join dado_capturado as dc
		on a.fk_dado_maquina = dc.id
	join maquina_dado_monitorado as mdm
		on mdm.fk_maquina = dc.fk_maquina
	join maquina as m
		on mdm.fk_maquina = m.id
	where dc.fk_empresa = ${idEmpresa}
    AND WEEK(dc.data_hora) = WEEK(CURRENT_DATE) 
	and dc.fk_dado_monitorado = 3
    and m.fk_tipo_maquina = 1;`;


    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);

}

function regressaoServidor(idEmpresa) {

    var instrucaoSql = `select * from alerta as a
	join dado_capturado as dc
		on a.fk_dado_maquina = dc.id
	join maquina_dado_monitorado as mdm
		on mdm.fk_maquina = dc.fk_maquina
	join maquina as m
		on mdm.fk_maquina = m.id
	where dc.fk_empresa = ${idEmpresa}
    and m.fk_tipo_maquina = 1
    AND WEEK(dc.data_hora) = WEEK(CURRENT_DATE) 
    order by dc.data_hora;`;


    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);

}

function treemapS(idEmpresa) {

    var instrucaoSql = `SELECT 
    m.id AS maquina_id,
    m.endereco_mac AS endereco_mac,
    COUNT(a.id) AS total_alertas
FROM 
    alerta a
JOIN 
    dado_capturado dc ON a.fk_dado_maquina = dc.id
JOIN 
    maquina m ON dc.fk_maquina = m.id
WHERE 
    m.fk_tipo_maquina = 1
    AND dc.fk_empresa = ${idEmpresa}
    AND WEEK(dc.data_hora) = WEEK(CURRENT_DATE) 
GROUP BY 
    m.id, m.endereco_mac
ORDER BY 
    total_alertas DESC;`;


    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);

}



module.exports = {
    qtdServidor,
    qtdAlertaAtualS,
    qtdAlertaPassadoS,
    histCpuS,
    histRamS,
    histDiscoS,
    regressaoServidor,
    treemapS
}
