var usuarioModel = require("../models/usuarioModel");
var empresaModel = require("../models/empresaModel")

function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {

        usuarioModel.autenticar(email, senha)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String
                    if (resultadoAutenticar.length == 1) {
                        console.log(resultadoAutenticar);
                        res.json(resultadoAutenticar)
                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function cadastrar(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var nome = req.body.nomeServer;
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;
    var cargo = req.body.cargoServer;
    var fkEmpresa = req.body.fkEmpresaServer;

    // Faça as validações dos valores
    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
    } else if (fkEmpresa == undefined) {
        res.status(400).send("Sua empresa a vincular está undefined!");
    } else {

        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        usuarioModel.cadastrar(nome, email, senha, cargo, fkEmpresa)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

function editarFuncionario(req, res) {
    var nomeCompleto = req.body.nomeCompletoServer
    var email = req.body.emailServer
    var senha = req.body.senhaServer
    var cargoId = req.body.cargoIdServer
    var id = req.params.idFuncionario;

    usuarioModel.editarFuncionario(nomeCompleto, email, senha, cargoId, id)
        .then(
            function (resultado) {
                res.json(resultado);
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao realizar o post: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );

}

function verificarEmail(req, res) {

    var email = req.params.email;

    usuarioModel.verificarEmail(email).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function trocarSenha(req, res) {
    var id = req.params.idFuncionario;
    var senha = req.body.senhaServer

    usuarioModel.trocarSenha(id, senha)
        .then(
            function (resultado) {
                res.json(resultado);
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao realizar o post: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function cadastrarPrimeiroFunc(req, res) {
    var nome = req.body.nomeServer
    var email = req.body.emailServer
    var senha = req.body.senhaServer
    var cnpj = req.params.cnpj
    var fkEmpresa
    var cargo = 1

    empresaModel.buscarPorCnpj(cnpj).then((resultado) => {
        fkEmpresa = resultado[0].id
        usuarioModel.cadastrar(nome, email, senha, cargo, fkEmpresa) 
        .then(
            function (resultado) {
                res.json(resultado);
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao realizar o post: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );
    }
    )
    
}

// function listarUsuarios(req, res) {
//     usuarioModel.listarTodos()
//         .then(
//             function (resultado) {
//                 res.json(resultado)
//             }
//         )

//         .catch(
//             function (erro) {
//                 console.log(erro)
//                 res.status(500).json(erro.sqlMessage)
//             }
//         )
// }

function listar(req, res) {
    var idEmpresa = req.params.idEmpresa
    usuarioModel.listar(idEmpresa)
        .then(
            function (resultado) {
                res.json(resultado)
            }
        )

        .catch(
            function (erro) {
                console.log(erro)
                res.status(500).json(erro.sqlMessage)
            }
        )
}

function deletarFuncionario(req, res) {
    const idFuncionario = req.params.id

    usuarioModel.deletarFunc(idFuncionario)
        .then(result => {
            if (result.affectedRows > 0) {
                res.status(200).json({ success: true, message: 'Funcionário excluído com sucesso.' });
            } else {
                res.status(404).json({ success: false, message: 'Funcionário não encontrado.' });
            }
        })
        .catch(error => {
            console.error(error);
            res.status(500).json({ success: false, message: 'Erro ao tentar excluir o funcionário.' });
        });
}



module.exports = {
    trocarSenha,
    verificarEmail,
    autenticar,
    cadastrar,
    editarFuncionario,
    cadastrarPrimeiroFunc,
    listar,
    deletarFuncionario
}