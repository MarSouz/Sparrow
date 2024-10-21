var database = require("../database/config");

function buscarUltimasMedidas(idAquario, limite_linhas) {

    var instrucaoSql = `SELECT 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        momento,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico
                    FROM medida
                    WHERE fk_aquario = ${idAquario}
                    ORDER BY id DESC LIMIT ${limite_linhas}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMaquina(idEmpresa, tipoMaquina) {

    var instrucaoSql = `SELECT * FROM buscarMaquina WHERE idEmpresa = ${idEmpresa} AND fk_tipo_maquina = ${tipoMaquina};`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function editarMaquinas(idMaquina, longitude, latitude, limiteCPU, limiteRam, limiteDisco) {
    var instrucaoSql = `UPDATE localizacao SET latitude = ${latitude}, longitude = ${longitude} WHERE id = ${idMaquina}`;
    var instrucaoSq2 = `UPDATE maquina_componente SET limite_componente = ${limiteCPU} WHERE fk_maquina = ${idMaquina} AND fk_componente_maquina = 1`;
    var instrucaoSq3 = `UPDATE maquina_componente SET limite_componente = ${limiteRam} WHERE fk_maquina = ${idMaquina} AND fk_componente_maquina = 2`;
    var instrucaoSq4 = `UPDATE maquina_componente SET limite_componente = ${limiteDisco} WHERE fk_maquina = ${idMaquina} AND fk_componente_maquina = 3`;

    console.log("Executando as instruções SQL: \n" + instrucaoSql + "\n" + instrucaoSq2 + "\n" + instrucaoSq3 + "\n" + instrucaoSq4);

    return database.executar(instrucaoSql)
        .then(() => database.executar(instrucaoSq2))
        .then(() => database.executar(instrucaoSq3))
        .then(() => database.executar(instrucaoSq4));
}


function deletarMaquina(idMaquina) {

    var instrucaoSql = `DELETE FROM maquina WHERE id= ${idMaquina}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}



// TERMINAIS
function buscarMaquinaTerminal(idEmpresa, tipoTerminal) {

    var instrucaoSql = `SELECT * FROM buscarMaquinaTerminal WHERE idEmpresa = ${idEmpresa} AND fk_tipo_maquina = ${tipoTerminal};`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function editarMaquinaTerminal(idMaquinaTerminal, longitude, latitude, limiteCPU, limiteRam, limiteDisco) {
    var instrucaoSql = `UPDATE localizacao SET latitude = ${latitude}, longitude = ${longitude} WHERE id = ${idMaquinaTerminal}`;
    var instrucaoSq2 = `UPDATE maquina_componente SET limite_componente = ${limiteCPU} WHERE fk_maquina = ${idMaquinaTerminal} AND fk_componente_maquina = 1`;
    var instrucaoSq3 = `UPDATE maquina_componente SET limite_componente = ${limiteRam} WHERE fk_maquina = ${idMaquinaTerminal} AND fk_componente_maquina = 2`;
    var instrucaoSq4 = `UPDATE maquina_componente SET limite_componente = ${limiteDisco} WHERE fk_maquina = ${idMaquinaTerminal} AND fk_componente_maquina = 3`;

    console.log("Executando as instruções SQL: \n" + instrucaoSql + "\n" + instrucaoSq2 + "\n" + instrucaoSq3 + "\n" + instrucaoSq4);

    return database.executar(instrucaoSql)
        .then(() => database.executar(instrucaoSq2))
        .then(() => database.executar(instrucaoSq3))
        .then(() => database.executar(instrucaoSq4));
}


function deletarMaquinaTerminal(idMaquinaTerminal) {

    var instrucaoSql = `DELETE FROM maquina WHERE id= ${idMaquinaTerminal}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}





module.exports = {
    buscarUltimasMedidas,
    buscarMaquina,
    editarMaquinas,
    deletarMaquina, 

    buscarMaquinaTerminal, 
    editarMaquinaTerminal,
    deletarMaquinaTerminal
}


