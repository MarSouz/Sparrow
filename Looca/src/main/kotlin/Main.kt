import com.github.britooo.looca.api.core.Looca
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit

open class Main {
    companion object {
        @JvmStatic
        fun main(args: Array<String>) {
            println("Olá! Seja bem-vindo à Sparrow Tech Solutions. Estamos aqui para ajudá-lo a capturar os pacotes de rede e monitorar sua conexão.")
            print("Pronto para começar? Digite 1 para iniciar a captura: ")

            val inicio = readln().toInt()
            val executor = Executors.newSingleThreadExecutor()

            if (inicio == 1) {
                val repositorio = MaquinaRepositorio()
                repositorio.configurar()
                val looca = Looca()

                while (true) {
                    var userInput: String? = null


                    val interfaces = looca.rede.grupoDeInterfaces.interfaces
                    val interfaceDeConexaoPrincipal = interfaces.filter { it.nome.lowercase().contains("wlan2") }

                    if (interfaceDeConexaoPrincipal.isNotEmpty()) {
                        val pacotesEnviados = interfaceDeConexaoPrincipal[0].pacotesEnviados
                        val pacotesRecebidos = interfaceDeConexaoPrincipal[0].pacotesRecebidos

                        val dadoPacotesEnviados = DadoCapturado().apply {
                            setRegistro(pacotesEnviados)
                            setComponenteMaquina(4)
                        }
                        val sucessoEnviados = repositorio.inserir(dadoPacotesEnviados)

                        val dadoPacotesRecebidos = DadoCapturado().apply {
                            setRegistro(pacotesRecebidos)
                            setComponenteMaquina(5)
                        }
                        val sucessoRecebidos = repositorio.inserir(dadoPacotesRecebidos)

                        println(
                            """
                            Pacotes Enviados: $pacotesEnviados
                            Pacotes Recebidos: $pacotesRecebidos
                            """.trimIndent()
                        )

                        if (sucessoEnviados && sucessoRecebidos) {
                            println("Inserido no banco de dados com sucesso!")
                        }
                    }
                    val task = Runnable {
                        print("Para parar a captura, digite 2 ou aguarde para continuar: ")
                        userInput = readln()
                    }

                    val future = executor.submit(task)
                    try {
                        future.get(5, TimeUnit.SECONDS)
                    } catch (e: Exception) {
                        // Exceção ignorada; o usuário não digitou nada a tempo
                    }

                    if (userInput == "2") {
                        println("Parando a captura.")
                        break
                    }
                    else{
                        println("Opção inválida.")
                    }
                }

                executor.shutdown() // Encerra o executor após a captura
            } else {
                println("Opção inválida.")
            }

        }
    }
}

