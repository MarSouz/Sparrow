var database = require("../database/config");

function buscarTotalAlertas(idEmpresa, idMaquina, tipoMaquina ) {

    var instrucaoSql = `SELECT
    e.id AS id_empresa,
    m.id AS id_maquina,
    tm.nome AS tipo_maquina,
    dm.nome AS componente,
    COUNT(a.id) AS total_alertas,
    MONTH(dc.data_hora) AS mes,
    YEAR(dc.data_hora) AS ano
FROM
    alerta a
JOIN
    dado_capturado dc ON a.fk_dado_maquina = dc.id
JOIN
    maquina m ON dc.fk_maquina = m.id
JOIN
    empresa e ON m.fk_empresa = e.id
JOIN
    tipo_maquina tm ON m.fk_tipo_maquina = tm.id
JOIN
    dado_monitorado dm ON dc.fk_dado_monitorado = dm.id
WHERE
    e.id = ${idEmpresa}
    AND m.id = ${idMaquina}
    AND tm.id = ${tipoMaquina}
    AND MONTH(dc.data_hora) = 11 
GROUP BY
    e.id, m.id, tm.nome, dm.nome, YEAR(dc.data_hora), MONTH(dc.data_hora)
ORDER BY
    ano DESC, mes DESC, m.id;
`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
  buscarTotalAlertas
}