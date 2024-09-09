val listaUsuarios = mutableListOf<Usuario>()
val listaTerminais = mutableListOf<Terminais>()
val listaServidores = mutableListOf<Servidores>()
var usuarioLogado: Usuario? = null

fun main() {

    while (true) {
        println(
            """
    |======================|
    |SPARROW TECH SOLUTIONS|
    |======================|  
          
     Selecione a ação:
     1 - Fazer Login
     2 - Sair
        """.trimIndent()
        )

        val resposta = readln()

        when (resposta) {
            "1" -> {
                if (verificaLoginUsuario()) {
                    prosseguir()
                }
            }

            "2" -> {
                println("Saindo...")
                break
            }

        }
    }
}

fun verificaLoginUsuario(): Boolean {
    while (true) {

        println("""
    |======================|
    |SPARROW TECH SOLUTIONS|
    |======================|  
    Tela de Login:
        """.trimIndent())

        println("\nDigite seu e-mail:")
       val inputEmail = readln()
        println("\nDigite sua senha:")
       val inputSenha = readln()

        if (inputEmail == "sparrow@admin.com" && inputSenha == "admin1234") {

            println(
                """
                 Selecione a ação:
                 1 - Criar novo usuário
                 2 - Sair
                 """.trimIndent()
            )

            val resposta = readln()
            when (resposta) {
                "1" -> {
                    cadastrarUsuario()
                }

                "2" -> break
            }

        } else {

            val usuarioEncontrado = listaUsuarios.find {it.email == inputEmail && it.senha == inputSenha}

            return if (usuarioEncontrado != null) {
                usuarioLogado = usuarioEncontrado
                println("Login realizado com sucesso! Bem-vindo, ${usuarioLogado!!.nome}.")
                Thread.sleep(1_000)
                true
            } else {
                println("A senha e/ou o email inseridos não estão corretos!")
                Thread.sleep(1_000)
                false
            }

        }
    }
    return false
}


fun cadastrarUsuario(){
    println("Nome do Usuário:\n")
   val nome = readln()
    println("Email do Usuário:\n")
    val email = readln()
    println("Senha do Usuário:\n")
    val senha = readln()
    var inputTipo = ""

    while (true){

        println("""
           Selecione o tipo de Usuário:
            1 - Usuário Comum
            2 - Usuário Administrador
        """.trimIndent())

        val resposta = readln()


        when (resposta){
            "1" -> {
                inputTipo = "Comum"
                println("Tipo de usuário definido para Comum ")
                Thread.sleep(1_000)
                break
            }

            "2" -> {
                inputTipo = "Administrador"
                println("Tipo de usuário definido para Administrador ")
                Thread.sleep(1_000)
                break
            }
            else -> {
                println("Valor inserido inválido! Tente novamente ")
                Thread.sleep(1_000)
            }
        }
    }
    val usuario = Usuario(nome,email,senha, inputTipo)

    listaUsuarios.add(usuario)

}


fun prosseguir() {

    while (true){

        println(
            """
    |======================|
    |SPARROW TECH SOLUTIONS|
    |======================|         
    """.trimIndent()
        )

        println(
            """
    Olá, ${usuarioLogado?.nome}! O que você deseja fazer?
    Seleciona uma das opções abaixo:
    """.trimIndent()
        )


        if(usuarioLogado?.tipoPerfil == "Comum"){
            println(
                """
            1 - Ver seus terminais
            2 - Configuração de perfil
            3 - Sair
        """.trimIndent()
            )

        } else {

            println( """
            1 - Ver seus terminais / Servidores
            2 - Configuração de perfil
            3 - Gerenciar Usuários
            4 - Cadastrar novo Terminal/Servidor
            5 - Sair 
        """.trimIndent())

        }

        var resposta = readln()

        when {

            ((resposta == "5" && usuarioLogado?.tipoPerfil == "Administrador") || (resposta == "3" && usuarioLogado?.tipoPerfil == "Comum")) ->{
                usuarioLogado = null
                break
            }

            (resposta == "1" && usuarioLogado?.tipoPerfil == "Comum") -> {

                if (listaTerminais.isEmpty()) {
                    println("Ainda não há nenhum Terminal cadastrado no sistema")
                } else {

                    for (exibeLista in usuarioLogado!!.listaTerminaisDoUsuario) {
                        println("\n Terminal: T-${exibeLista.idTerminal}")
                    }
                }
                println("Aperte qualquer tecla para prosseguir:")
                val prosseguir = readln()
            }



            (resposta == "1" && usuarioLogado?.tipoPerfil == "Administrador") -> {

                if (listaTerminais.isEmpty()) {
                    println("Ainda não há nenhum Terminal cadastrado no sistema")
                } else {

                    for (exibeLista in usuarioLogado!!.listaTerminaisDoUsuario) {
                        println("\n Terminal: T-${exibeLista.idTerminal}")
                    }
                }

                if (listaServidores.isEmpty()) {
                    println("Ainda não há nenhum Servidor cadastrado no sistema")
                } else {
                    for (exibeLista in usuarioLogado!!.listaServidoresDoUsuario) {
                        println("\n Servidor: S-${exibeLista.idServidor}")
                    }
                }
                println("Aperte qualquer tecla para prosseguir:")
                val prosseguir = readln()
            }

            resposta == "2"-> {
                println( """
                1 - Mudar Senha
                2 - Voltar
            """.trimIndent())

                resposta = readln()

                if (resposta == "1"){
                    usuarioLogado?.mudarSenhaUsuario()
                }
            }

            (resposta == "3" && usuarioLogado?.tipoPerfil == "Administrador") ->{
               """
                   ========================================================
                   |                       USUÁRIOS                       |
                   ========================================================
               """.trimIndent()

                println("ID | TIPO DE PERFIL | NOME | email | QTD DE TERMINAIS | QTD DE SERVIDORES |")

                for ((idUsuarioLista, exibeListaUsuario) in listaUsuarios.withIndex()) {
                    println("\n ${idUsuarioLista + 1} | ${exibeListaUsuario.tipoPerfil} | ${exibeListaUsuario.nome} | ${exibeListaUsuario.email} | ${exibeListaUsuario.listaTerminaisDoUsuario.count()} | ${exibeListaUsuario.listaServidoresDoUsuario.count()}")

                }
                println("Aperte qualquer tecla para prosseguir:")
                val prosseguir = readln()
            }

            (resposta == "4" && usuarioLogado?.tipoPerfil == "Administrador") ->{

                println("""
                    O que você deseja cadastrar?
                    1 - Terminal
                    2 - Servidor
                    3 - Voltar
                """.trimIndent())

                resposta = readln()

                while (true){
                    when (resposta){
                        "1" -> {
                            val novoTerminal = Terminais()
                            println("Digite o id do terminal:")
                            novoTerminal.idTerminal = readln()
                            listaTerminais.add(novoTerminal)

                            for ((idUsuarioLista, exibeListaUsuario) in listaUsuarios.withIndex()) {
                                println("\n ${idUsuarioLista + 1} | ${exibeListaUsuario.tipoPerfil} | ${exibeListaUsuario.nome}")
                            }

                            println("Selecione qual usuário será responsável por esse terminal: (ID)")
                            val idEscolha = readln().toInt()
                            val usuarioEscolhido = listaUsuarios[idEscolha - 1]

                            usuarioEscolhido.listaTerminaisDoUsuario.add(novoTerminal) //eu estou pessoalmente orgulhoso de ter conseguido fazer isso aqui :)
                            break
                        }

                        "2" -> {

                            val novoServidor = Servidores()
                            println("Digite o id do servidor:")
                            novoServidor.idServidor = readln()
                            listaServidores.add(novoServidor)

                            for ((idUsuarioLista, exibeListaUsuario) in listaUsuarios.withIndex()) {
                                println("\n ${idUsuarioLista + 1} | ${exibeListaUsuario.tipoPerfil} | ${exibeListaUsuario.nome}")
                            }

                            while (true){
                                println("Selecione qual usuário será responsável por esse servido: (ID)")
                                val idEscolha = readln().toInt()
                                val usuarioEscolhido = listaUsuarios[idEscolha - 1]

                                if (usuarioEscolhido.tipoPerfil != "Administrador"){
                                    println("Usuários do tipo comum não tem permissão de monitorar servidores")
                                }
                                else{
                                    usuarioEscolhido.listaServidoresDoUsuario.add(novoServidor)
                                    break
                                }
                            }
                           break
                        }

                        "3" -> {

                            println("voltando...")
                            break

                        }

                        else ->{
                            println("Valor inválido inserido, por favor tente novamente!")
                        }
                    }
                }
            }
        }
    }
}






