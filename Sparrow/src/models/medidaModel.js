var database = require("../database/config");

function buscarMaquina(idEmpresa, tipoMaquina) {
    // SELECT * FROM maquina WHERE fk_empresa = ${idEmpresa} AND fk_tipo_maquina = ${tipoMaquina};

    var instrucaoSql = `SELECT 
    m.id AS id,
    m.fk_empresa as fk_empresa,
    c.latitude as lat, 
    c.longitude as lon,
    c.id as idcoordenada,
    MAX(CASE WHEN tc.nome = 'Uso de CPU' THEN mc.limite_componente END) AS CPU,
    MAX(CASE WHEN tc.nome = 'Uso de RAM' THEN mc.limite_componente END) AS RAM,
    MAX(CASE WHEN tc.nome = 'Uso do Disco' THEN mc.limite_componente END) AS Disco
FROM 
    maquina m
JOIN 
    maquina_dado_monitorado mc ON mc.fk_maquina = m.id
JOIN 
    dado_monitorado tc ON mc.fk_dado_monitorado = tc.id
LEFT JOIN 
    coordenada c ON c.id = m.fk_coordenada 
WHERE 
    m.fk_empresa = ${idEmpresa} and m.fk_tipo_maquina = ${tipoMaquina}
GROUP BY 
    m.id`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function inserirLocalizacao(latitude, longitude){
    var instrucaoSql = `INSERT INTO coordenada VALUES (DEFAULT, ${latitude}, ${longitude})`

    return database.executar(instrucaoSql)
}

function buscarLocalizacao(latitude, longitude){
    var instrucaoSql = `SELECT * FROM coordenada WHERE latitude = ${latitude} AND longitude = ${longitude}`

    return database.executar(instrucaoSql)
}

function atualizarLocalizacao(latitude, longitude, idcoordenada){
    var instrucaoSql = `UPDATE coordenada SET latitude = ${latitude}, longitude = ${longitude} WHERE id = ${idcoordenada}`;

    return database.executar(instrucaoSql)
}

function atribuirLocalizacao(idcoordenada, idMaquina, idEmpresa){
    var instrucaoSql = ` UPDATE maquina SET fk_coordenada = ${idcoordenada} WHERE id = ${idMaquina} AND fk_empresa = ${idEmpresa}`;

    return database.executar(instrucaoSql)
}

function editarMaquinas(idMaquina, idEmpresa, limiteCPU, limiteRam, limiteDisco) {
    var instrucaoSql2 = `UPDATE maquina_dado_monitorado SET limite_componente = ${limiteCPU} WHERE fk_maquina = ${idMaquina} AND fk_empresa = ${idEmpresa} AND fk_dado_monitorado = 1`;
    var instrucaoSql3 = `UPDATE maquina_dado_monitorado SET limite_componente = ${limiteRam} WHERE fk_maquina = ${idMaquina} AND fk_empresa = ${idEmpresa} AND fk_dado_monitorado = 2`;
    var instrucaoSql4 = `UPDATE maquina_dado_monitorado SET limite_componente = ${limiteDisco} WHERE fk_maquina = ${idMaquina} AND fk_empresa = ${idEmpresa} AND fk_dado_monitorado = 3`;


    console.log("Executando as instruções SQL: \n" + instrucaoSql2 + "\n" + instrucaoSql3 + "\n" + instrucaoSql4 );

    return database.executar(instrucaoSql2)
        .then(() => database.executar(instrucaoSql3))
        .then(() => database.executar(instrucaoSql4));
}


function deletarMaquina(idMaquina, idEmpresa) {
    var instrucaoSql = `DELETE FROM dado_capturado WHERE fk_maquina = ${idMaquina} AND fk_empresa = ${idEmpresa}`

    database.executar(instrucaoSql)

    var instrucaoSql = `DELETE FROM maquina_dado_monitorado WHERE fk_maquina = ${idMaquina} and fk_empresa = ${idEmpresa}`

    database.executar(instrucaoSql)

    var instrucaoSql = `DELETE FROM maquina WHERE id = ${idMaquina} and fk_empresa = ${idEmpresa}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}



module.exports = {
    buscarMaquina,
    editarMaquinas,
    deletarMaquina,
    buscarLocalizacao,
    inserirLocalizacao,
    atualizarLocalizacao,
    atribuirLocalizacao,
}


