fun main (){
    val usuario = Usuario()

    while (true){
        println("""
           Selecione a ação:
            1 - Fazer Login
            2 - Sair
        """.trimIndent())

        var resposta = readln()

        when (resposta){
            "1" ->{
                verificaLoginUsuario(usuario)

                if (verificaLoginUsuario(usuario)){
                    prosseguir(usuario)

                }

            }

            "2" -> {
                println("Saindo...")
                break
            }

        }
    }
}
var inputEmail = ""
var inputSenha = ""

fun verificaLoginUsuario(usuario: Usuario):Boolean {
    while (true){

            println("\nDigite seu e-mail:")
             inputEmail = readln()
            println("\nDigite sua senha:")
             inputSenha = readln()

            if (inputEmail == "sparrow@admin.com" && inputSenha == "admin1234"){

                println("""
                 Selecione a ação:
                 1 - Criar novo usuário
                 2 - Sair
                 """.trimIndent())

                var resposta = readln()

                when(resposta){
                    "1" -> {
                        usuario.cadastrarUsuario()
                        adicionaUsuarioLista(usuario)
                    }
                    "2" -> break
                }

            } else if (verificaUsuarioJaExiste()){
                println("Olá ${usuario.nome}")
                return true
            } else{
                println("Senha/email incorretos")
                return false
            }
        }

    return false
    }

val listaUsuarios = mutableListOf<Usuario>()
fun adicionaUsuarioLista(usuario:Usuario){
    listaUsuarios.add(usuario)
}

fun verificaUsuarioJaExiste(): Boolean{

    for (atual in listaUsuarios){
        if (atual.email == inputEmail && atual.senha == inputSenha)
           return true
    }
    return false
}

fun prosseguir(usuario: Usuario){
    println("""
    |======================|
    |SPARROW TECH SOLUTIONS|
    |======================|         
    """.trimIndent())

    println("""
    Olá, ${usuario.nome}! O que você deseja fazer?
    Seleciona uma das opções abaixo:
    """.trimIndent())

    when(usuario.tipoPerfil){

        "Comum" ->{
            println( """
            1 - Ver seus terminais
            2 - Configuração de perfil
            3 - Sair
        """.trimIndent())
        }

        "Administrador" ->{
            """
            1 - Ver seus terminais / Servidores
            2 - Configuração de perfil
            3 - Gerênciar Usuários
            4 - Cadastrar novo Terminal/Servidor
            5 - Sair 
        """.trimIndent()
        }
    }

    var resposta = readln()

    when{
        (resposta == "1" && usuario.tipoPerfil == "Comum") ->{

            if (usuario.listaTerminais.isEmpty()){
                    println("Ainda não há nenhum Terminal cadastrado no sistema")
                } else {

                for (exibeLista in usuario.listaTerminais){
                    println("\n Terminal: ${exibeLista} | Responsáveis: | ID: | Localidade:")

                }


            }

        }
    }

    }






