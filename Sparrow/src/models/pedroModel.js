var database = require("../database/config");

// Função para buscar os dados do gráfico semanal com base no componente selecionado
function buscarDadosSemanal(componente, idEmpresa, idMaquina) {
    // Consulta SQL que retorna o maior valor de 'registro' para cada dia dos últimos 7 dias
    const instrucaoSql = `
        SELECT 
    DATE_FORMAT(dados, '%d-%m-%Y') AS data_formatada, 
    MAX(registro) AS maior_registro, 
    CASE DAYOFWEEK(dados) 
        WHEN 1 THEN 'Domingo' 
        WHEN 2 THEN 'Segunda-feira' 
        WHEN 3 THEN 'Terça-feira' 
        WHEN 4 THEN 'Quarta-feira' 
        WHEN 5 THEN 'Quinta-feira' 
        WHEN 6 THEN 'Sexta-feira' 
        WHEN 7 THEN 'Sábado' 
    END AS dia_da_semana 
FROM (
    SELECT 
        DATE(data_hora) AS dados, 
        registro 
    FROM 
        Sparrow.dado_capturado 
    WHERE 
        DATE(data_hora) >= CURDATE() - INTERVAL 7 DAY 
        AND fk_dado_monitorado = ${componente}
        AND fk_empresa = ${idEmpresa}
        AND fk_maquina = ${idMaquina}
) AS dados_agrupados 
GROUP BY 
    dados 
ORDER BY 
    dados ASC, 
    DAYOFWEEK(dados) 
LIMIT 7;


    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
};


function buscarDadosLimiteSemanal(idEmpresa, idMaquina) {
    let instrucaoSql = `
    SELECT 
    COALESCE(COUNT(a.id), 0) AS ultrapassagens,
    m.id AS fk_maquina,
    dc.fk_dado_monitorado
FROM Sparrow.maquina m
LEFT JOIN Sparrow.dado_capturado dc
    ON m.id = dc.fk_maquina
    AND m.fk_empresa = dc.fk_empresa
    AND dc.data_hora >= NOW() - INTERVAL 7 DAY
LEFT JOIN Sparrow.alerta a
    ON a.fk_dado_maquina = dc.id
WHERE m.fk_empresa = ${idEmpresa}
  AND m.id = ${idMaquina}
GROUP BY m.id, dc.fk_dado_monitorado;`

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listar(idEmpresa, tipoMaquina) {
    var instrucaoSql = `
    SELECT 
        COALESCE(COUNT(a.id), 0) AS total_alertas,
        m.id AS fk_maquina
    FROM Sparrow.maquina m
    LEFT JOIN Sparrow.dado_capturado dc
        ON m.id = dc.fk_maquina
        AND m.fk_empresa = dc.fk_empresa
        AND dc.data_hora >= NOW() - INTERVAL 7 DAY
    LEFT JOIN Sparrow.alerta a
        ON a.fk_dado_maquina = dc.id
    WHERE m.fk_empresa = ${idEmpresa} 
    AND m.fk_tipo_maquina = ${tipoMaquina}
    GROUP BY m.id;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);

}

module.exports = {
    buscarDadosSemanal,
    buscarDadosLimiteSemanal,
    listar
};
