class Usuario (
   var nome: String = "",
   var email:String = "",
   var senha:String = "",
   var tipoPerfil:String = "",
   var listaTerminais:MutableList<Terminais> = mutableListOf(),
   var listaServidores:MutableList<Servidores> = mutableListOf())
{
    fun cadastrarUsuario(){
        println("Nome do Usuário:\n")
        nome = readln()
        println("Email do Usuário:\n")
        email = readln()
        println("Senha do Usuário:\n")
        senha = readln()
        cadastraTipoUsuario()
        associaTerminaisUsuario()
        associaServidoresUsuario()

        }

    fun cadastraTipoUsuario(){

        while (true){

            println("""
           Selecione o tipo de Usuário:
            1 - Usuário Comum
            2 - Usuário Administrador
        """.trimIndent())

            val inputTipo = readln()

            when (inputTipo){
                "1" -> {
                    tipoPerfil = "Comum"
                    println("Tipo de usuário definido para Comum ")
                    break
                }

                "2" -> {
                    tipoPerfil = "Administrador"
                    println("Tipo de usuário definido para Administrador ")
                    break
                }

                else -> {
                    println("Valor inserido inválido! Tente novamente ")
                }

            }
        }


    }

    fun associaTerminaisUsuario(){

        println("Escolhas quais Terminais você deseja associar a este usuário:")

        if (listaTerminais.isEmpty()){
            println("Ainda não há nenhum Terminal cadastrado no sistema")
        }
    }

    fun associaServidoresUsuario(){

        println("Escolhas quais Servidores você deseja associar a este usuário:")

        if (listaServidores.isEmpty()){
            println("Ainda não há nenhum Servidor cadastrado no sistema")
        }
    }


    fun mudarSenhaUsuario(){

        while (true){
            println("Digite a sua Nova Senha:\n")
            val senhaA = readln()
            println("Confirme a sua Nova Senha:\n")
            val senhaB = readln()

            if (senhaA == senhaB){
                senha = senhaA
            } else{
                """
                    As senhas inseridas não coincidem! Deseja tentar novamente?
                    1 - Sim
                    2 - Não, Voltar
                """.trimIndent()
                val resposta = readln()
                    if (resposta == "2"){
                        break
                    }

            }

        }


        senha = readln()
    }



}