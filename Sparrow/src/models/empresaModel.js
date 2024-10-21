var database = require("../database/config");

function buscarPorId(id) {
  var instrucaoSql = `SELECT * FROM empresa WHERE id = '${id}'`;

  return database.executar(instrucaoSql);
}

function editarEmpresa(nomeEmpresa, nomeRepresentante, emailRepresentante, cnpj, id) {
  console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nomeEmpresa, nomeRepresentante, emailRepresentante,cnpj,id);
  
  // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
  //  e na ordem de inserção dos dados.
  var instrucaoSql = `
      UPDATE empresa SET nome_empresa = "${nomeEmpresa}", nome_representante = "${nomeRepresentante}", email_representante = "${emailRepresentante}", cnpj = "${cnpj}" WHERE id = ${id}
  `;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrarContato(nomeEmpresa, nomeRepresentante, email, cnpj, descricao) {
  console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nomeEmpresa, nomeRepresentante, email, descricao,cnpj);
  
  var instrucaoSql = `
      INSERT INTO possivel_cliente (id, nome_empresa, nome_representante, email_representante, cnpj, descricao) VALUES (DEFAULT,'${nomeEmpresa}', '${nomeRepresentante}', '${email}', '${cnpj}', '${descricao}');
  `;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function listar() {
  var instrucaoSql = `SELECT * FROM empresa`;

  return database.executar(instrucaoSql);
}

function buscarPorCnpj(cnpj) {
  var instrucaoSql = `SELECT * FROM empresa WHERE cnpj = '${cnpj}'`;

  return database.executar(instrucaoSql);
}

function cadastrar(nomeEmpresa,nomeRepresentante,emailRepresentante ,cnpj) {
  var instrucaoSql = `INSERT INTO empresa (id, nome_empresa, nome_representante, email_representante, cnpj) VALUES (DEFAULT, '${nomeEmpresa}','${nomeRepresentante}','${emailRepresentante}', '${cnpj}')`;

  return database.executar(instrucaoSql);
}

module.exports = { buscarPorCnpj, buscarPorId, cadastrar, listar, cadastrarContato, editarEmpresa };
