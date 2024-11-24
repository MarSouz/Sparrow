var database = require("../database/config");

// Função para buscar os dados do gráfico semanal com base no componente selecionado
function buscarDadosSemanal(componenteSelecionado) {
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
        AND Sparrow.dado_capturado.fk_dado_monitorado = ${componenteSelecionado}
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


function buscarDadosLimiteSemanal() {
    let instrucaoSql = `
    SELECT 
    fk_dado_monitorado,
    COUNT(*) AS ultrapassagens
FROM 
    dado_capturado
WHERE 
    data_hora >= CURDATE() - INTERVAL 7 DAY
    AND registro > 70
GROUP BY 
    fk_dado_monitorado;`

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarDadosSemanal,
    buscarDadosLimiteSemanal
};
