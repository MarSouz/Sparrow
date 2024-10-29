var database = require("../database/config");

function buscarMaquina(idEmpresa, tipoMaquina) {
    // SELECT * FROM maquina WHERE fk_empresa = ${idEmpresa} AND fk_tipo_maquina = ${tipoMaquina};

    var instrucaoSql = `SELECT 
    m.id AS id,
    m.fk_empresa as fk_empresa,
    l.latitude as lat, 
    l.longitude as lon,
    l.id as idlocalizacao,
    MAX(CASE WHEN tc.nome_componente = 'Uso de CPU' THEN mc.limite_componente END) AS CPU,
    MAX(CASE WHEN tc.nome_componente = 'Uso de RAM' THEN mc.limite_componente END) AS RAM,
    MAX(CASE WHEN tc.nome_componente = 'Uso do Disco' THEN mc.limite_componente END) AS Disco
FROM 
    maquina m
JOIN 
    maquina_componente mc ON mc.fk_maquina = m.id
JOIN 
    tipo_componente tc ON mc.fk_componente_maquina = tc.id
LEFT JOIN 
		localizacao l ON l.id = m.fk_localizacao 
WHERE 
    m.fk_empresa = ${idEmpresa} and m.fk_tipo_maquina = ${tipoMaquina}
GROUP BY 
    m.id;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function inserirLocalizacao(latitude, longitude){
    var instrucaoSql = `INSERT INTO localizacao VALUES (DEFAULT, ${latitude}, ${longitude})`

    return database.executar(instrucaoSql)
}

function buscarLocalizacao(latitude, longitude){
    var instrucaoSql = `SELECT * FROM localizacao WHERE latitude = ${latitude} AND longitude = ${longitude}`

    return database.executar(instrucaoSql)
}

function atualizarLocalizacao(latitude, longitude, idlocalizacao){
    var instrucaoSql = `UPDATE localizacao SET latitude = ${latitude}, longitude = ${longitude} WHERE id = ${idlocalizacao}`;

    return database.executar(instrucaoSql)
}

function atribuirLocalizacao(idlocalizacao, idMaquina){
    var instrucaoSql = `UPDATE maquina SET fk_localizacao = ${idlocalizacao} WHERE id = ${idMaquina}`;

    return database.executar(instrucaoSql)
}

function editarMaquinas(idMaquina,limiteCPU, limiteRam, limiteDisco) {
    var instrucaoSql2 = `UPDATE maquina_componente SET limite_componente = ${limiteCPU} WHERE fk_maquina = ${idMaquina} AND fk_componente_maquina = 1`;
    var instrucaoSql3 = `UPDATE maquina_componente SET limite_componente = ${limiteRam} WHERE fk_maquina = ${idMaquina} AND fk_componente_maquina = 2`;
    var instrucaoSql4 = `UPDATE maquina_componente SET limite_componente = ${limiteDisco} WHERE fk_maquina = ${idMaquina} AND fk_componente_maquina = 3`;


    console.log("Executando as instruções SQL: \n" + instrucaoSql2 + "\n" + instrucaoSql3 + "\n" + instrucaoSql4 );

    return database.executar(instrucaoSql2)
        .then(() => database.executar(instrucaoSql3))
        .then(() => database.executar(instrucaoSql4));
}


function deletarMaquina(idMaquina) {
    var instrucaoSql = `DELETE FROM dado_capturado WHERE fk_maquina = ${idMaquina}`

    database.executar(instrucaoSql)

    var instrucaoSql = `DELETE FROM maquina_componente WHERE fk_maquina = ${idMaquina}`

    database.executar(instrucaoSql)

    var instrucaoSql = `DELETE FROM maquina WHERE id = ${idMaquina}`;

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


