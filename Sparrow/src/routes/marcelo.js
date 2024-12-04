var database = require("../database/config");

function buscarTotalAlertas(idEmpresa, idMaquina, idMes) {

    var instrucaoSql = `SELECT 
    COALESCE(COUNT(a.id), 0) AS ultrapassagens,
    m.id AS fk_maquina,
    dc.fk_dado_monitorado
FROM Sparrow.maquina m
LEFT JOIN Sparrow.dado_capturado dc
    ON m.id = dc.fk_maquina
    AND m.fk_empresa = dc.fk_empresa
    AND MONTH(dc.data_hora) = ${idMes} -- Substitua pelo mês desejado
    AND YEAR(dc.data_hora) = 2024 
LEFT JOIN Sparrow.alerta a
    ON a.fk_dado_maquina = dc.id
WHERE m.fk_empresa = ${idEmpresa}
  AND m.id = ${idMaquina}
GROUP BY m.id, dc.fk_dado_monitorado;
`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarAlertas(idEmpresa, idMaquina, idMes) {

    var instrucaoSql = `SELECT a.id AS alerta_id,
       a.fk_dado_maquina,
       dc.data_hora,
       dc.fk_empresa,
       dc.fk_maquina,
       dc.fk_dado_monitorado,
       dc.registro
FROM Sparrow.alerta a
JOIN Sparrow.dado_capturado dc ON a.fk_dado_maquina = dc.id
WHERE dc.fk_maquina = ${idMaquina}
  AND dc.fk_empresa = ${idEmpresa}
  AND MONTH(dc.data_hora) = ${idMes}
ORDER BY dc.data_hora;
`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function graficoAnual() {

    var instrucaoSql = `SELECT 
    MONTH(dc.data_hora) AS mes,
    CONCAT('S-', FLOOR((DAY(dc.data_hora) - 1) / 7) + 1) AS semana, -- Semana com base em dias do mês
    COUNT(a.id) AS total_alertas,
    m.fk_empresa AS id_empresa,
    m.id AS id_maquina,
    tm.nome AS tipo_maquina
FROM 
    Sparrow.alerta a
JOIN 
    Sparrow.dado_capturado dc ON a.fk_dado_maquina = dc.id
JOIN 
    Sparrow.maquina m ON dc.fk_maquina = m.id
JOIN 
    Sparrow.tipo_maquina tm ON m.fk_tipo_maquina = tm.id
WHERE 
    m.fk_empresa = ${idEmpresa}
    AND m.id = ${idMaquina}
    AND tm.id = ${tipoMaquina}
    AND MONTH(dc.data_hora) = ${idMes}-- Substitua 11 pelo número do mês desejado
    AND YEAR(dc.data_hora) = YEAR(CURDATE()) -- Filtra o ano atual
GROUP BY 
    mes, semana, id_empresa, id_maquina, tipo_maquina
ORDER BY 
    semana;
`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
  buscarTotalAlertas,
  listarAlertas,
  graficoAnual
}