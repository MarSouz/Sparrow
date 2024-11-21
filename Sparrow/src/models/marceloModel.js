var database = require("../database/config");

function buscarTotalAlertas(idEmpresa, tipoMaquina, nome_componente, total_alertas) {

    var instrucaoSql = `SELECT 
    e.id AS id_empresa,
    tm.nome AS tipo_maquina,
    tc.nome_componente AS componente,
    COUNT(a.id) AS total_alertas
FROM 
    alerta a
JOIN 
    dado_capturado dc ON a.fk_dado_maquina = dc.id
JOIN 
    maquina_componente mc ON dc.fk_maquina = mc.fk_maquina AND dc.fk_componente_maquina = mc.fk_componente_maquina
JOIN 
    tipo_componente tc ON mc.fk_componente_maquina = tc.id
JOIN 
    maquina m ON mc.fk_maquina = m.id
JOIN 
    empresa e ON m.fk_empresa = e.id
JOIN 
    tipo_maquina tm ON m.fk_tipo_maquina = tm.id
GROUP BY 
    e.id, tm.nome, tc.nome_componente;
`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
  buscarTotalAlertas
}