class Usuario (
   var nome: String = "",
   var email:String = "",
   var senha:String = "",
   var tipoPerfil:String = "",
   var listaTerminaisDoUsuario: MutableList<Terminais> =  mutableListOf<Terminais>(),
   var listaServidoresDoUsuario: MutableList<Servidores> =  mutableListOf<Servidores>()
    )
{


    fun mudarSenhaUsuario(){

        while (true){
            println("MUDANÇA DE SENHA:\n")
            println("Digite a sua Nova Senha:\n")
            val senhaA = readln()
            println("Confirme a sua Nova Senha:\n")
            val senhaB = readln()

            if (senhaA == senhaB){
                senha = senhaA
                println("Senha redefinida com sucesso!:\n")
                break
            } else{

                println(
                    """
                    As senhas inseridas não coincidem! Deseja tentar novamente?
                    1 - Sim
                    2 - Não, Voltar
                """.trimIndent())

                val resposta = readln()
                    if (resposta == "2"){
                        break
                    }

            }

        }
    }



}