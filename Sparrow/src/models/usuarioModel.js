var database = require("../database/config");

function autenticar(email, senha) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)
    var instrucaoSql = `
        SELECT id, nome_completo as nome, email, fk_empresa as empresaId, fk_cargo FROM funcionario WHERE email = '${email}' AND senha = '${senha}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql

function cadastrar(nome, email, senha, cargo, fkEmpresa) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, email, senha, cargo, fkEmpresa);

    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `
        INSERT INTO funcionario (nome_completo, email, senha, fk_cargo, fk_empresa) VALUES ('${nome}', '${email}', '${senha}', ${cargo},${fkEmpresa});
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function editarFuncionario(nomeCompleto, email, senha, cargoId, id) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nomeCompleto, email, senha, cargoId, id)
    var instrucaoSql = `
        UPDATE funcionario SET nome_completo = '${nomeCompleto}', email = '${email}', senha = '${senha}', fk_cargo = ${cargoId} where id = ${id};`

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function verificarEmail(email) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", email)
    var instrucaoSql = `
        SELECT * FROM funcionario WHERE email = "${email}"`

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function trocarSenha(id, senha) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", id, senha)
    var instrucaoSql = `
        UPDATE funcionario SET senha = '${senha}' where id = ${id};`

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function cadastrar(nome_completo, email, senha, fk_cargo, fk_empresa) {
    var instrucaoSql = `
    insert into funcionario (nome_completo, email, senha, fk_empresa, fk_cargo) values ('${nome_completo}', '${email}', '${senha}', ${fk_empresa}, '${fk_cargo}') `

    return database.executar(instrucaoSql)
}

function listar(idEmpresa) {
    var instrucaoSql = `
    SELECT f.id, f.nome_completo, f.email,f.senha, c.id as fkcargo, c.nome FROM funcionario f join cargo c on f.fk_cargo = c.id where fk_empresa = ${idEmpresa} order by f.id`

    return database.executar(instrucaoSql)
}

function deletarFunc(idFuncionario) {
    var instrucaoSql = `
    delete from funcionario where id = ${idFuncionario} `
    return database.executar(instrucaoSql)
}

module.exports = {
    trocarSenha,
    verificarEmail,
    editarFuncionario,
    autenticar,
    cadastrar,
    listar,
    deletarFunc
};