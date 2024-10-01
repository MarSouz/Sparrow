var empresaModel = require("../models/empresaModel");

function buscarPorCnpj(req, res) {
  var cnpj = req.query.cnpj;

  empresaModel.buscarPorCnpj(cnpj).then((resultado) => {
    res.status(200).json(resultado);
  });
}

function listar(req, res) {
  empresaModel.listar().then((resultado) => {
    res.status(200).json(resultado);
  });
}

function buscarPorId(req, res) {
  var id = req.params.id;

  empresaModel.buscarPorId(id).then((resultado) => {
    res.status(200).json(resultado);
  });
}

function cadastrar(req, res) {
  var cnpj = req.body.cnpj;
  var razaoSocial = req.body.razaoSocial;

  empresaModel.buscarPorCnpj(cnpj).then((resultado) => {
    if (resultado.length > 0) {
      res
        .status(401)
        .json({ mensagem: `a empresa com o cnpj ${cnpj} já existe` });
    } else {
      empresaModel.cadastrar(razaoSocial, cnpj).then((resultado) => {
        res.status(201).json(resultado);
      });
    }
  });
}
function cadastrarContato(req, res) {
  // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
  var nomeEmpresa = req.body.nomeEmpresaServer;
  var email = req.body.emailServer;
  var nomeRepresentante = req.body.nomeRepresentanteServer;
  var cnpj = req.body.cnpjServer;
  var descricao = req.body.descricaoServer;
  // Faça as validações dos valores
  if (nomeEmpresa == undefined) {
      res.status(400).send("O nome da empresa está undefined!");
  } else if (email == undefined) {
      res.status(400).send("Seu email está undefined!");
  } else if (nomeRepresentante == undefined) {
      res.status(400).send("O nome do representante está undefined!");
  } else if (cnpj == undefined) {
      res.status(400).send("O cnpj da empresa está undefined!");
  }
  else if(descricao == undefined){
      res.status(400).send("Sua descrição está indefinida")
  } else {

      // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
      empresaModel.cadastrarContato(nomeEmpresa, nomeRepresentante, email,  cnpj, descricao)
          .then(
              function (resultado) {
                  res.json(resultado);
              }
          ).catch(
              function (erro) {
                  console.log(erro);
                  console.log(
                      "\nHouve um erro ao realizar o cadastr0! Erro: ",
                      erro.sqlMessage
                  );
                  res.status(500).json(erro.sqlMessage);
              }
          );
  }
}

module.exports = {
  buscarPorCnpj,
  buscarPorId,
  cadastrar,
  listar,
  cadastrarContato,
};
