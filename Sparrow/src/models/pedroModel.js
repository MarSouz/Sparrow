var database = require("../database/config");

// Função para buscar os dados do gráfico semanal com base no componente selecionado
const buscarDadosSemanal = (componenteSelecionado) => {
    // Consulta SQL que retorna o maior valor de 'registro' para cada dia dos últimos 7 dias
    const query = `
        SELECT 
            data,
            MAX(registro) AS maior_registro,
            CASE DAYOFWEEK(data)
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
                DATE(data_hora) AS data,
                registro
            FROM 
                Sparrow.dado_capturado
            WHERE 
                DATE(data_hora) >= CURDATE() - INTERVAL 7 DAY -- Filtra os últimos 7 dias
                AND componente = ? -- Filtra pelo componente (cpu, ram, disk, etc.)
        ) AS dados_agrupados
        GROUP BY 
            data
        ORDER BY 
            data ASC, -- Organiza por data (do mais antigo para o mais recente)
            DAYOFWEEK(data) -- Organiza os dias da semana (de segunda a domingo)
        LIMIT 7;
    `;

    return db.execute(query, [componenteSelecionado]) // Executa a consulta e retorna o resultado
        .then(([results]) => { 
            return results; // Retorna o resultado da consulta
        })
        .catch(err => {
            console.error("Erro ao executar a consulta: ", err);
            throw err; // Lança o erro para que possa ser tratado na controller
        });
};

module.exports = {
    buscarDadosSemanal,
};
