var database = require("../database/config");

function buscarTotalAlertas(idEmpresa, idMaquina, tipoMaquina ) {

    var instrucaoSql = `SELECT 
    e.id AS id_empresa,
    m.id AS id_maquina,
    m.fk_empresa as fk_empresa,
    tm.nome AS tipo_maquina,
    dm.nome AS componente,
    COUNT(a.id) AS total_alertas
FROM 
    alerta a
JOIN 
    dado_capturado dc 
    ON a.fk_dado_maquina = dc.id
JOIN 
    maquina_dado_monitorado mdm 
    ON dc.fk_empresa = mdm.fk_empresa 
       AND dc.fk_maquina = mdm.fk_maquina 
       AND dc.fk_dado_monitorado = mdm.fk_dado_monitorado
JOIN 
    dado_monitorado dm 
    ON mdm.fk_dado_monitorado = dm.id
JOIN 
    maquina m 
    ON mdm.fk_maquina = m.id
JOIN 
    empresa e 
    ON m.fk_empresa = e.id
JOIN 
    tipo_maquina tm 
    ON m.fk_tipo_maquina = tm.id
WHERE 
    e.id = ${idEmpresa}
    AND m.id = ${idMaquina}
    AND tm.id = ${tipoMaquina}
GROUP BY 
    e.id, m.id, tm.nome, dm.nome;
`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
  buscarTotalAlertas
}