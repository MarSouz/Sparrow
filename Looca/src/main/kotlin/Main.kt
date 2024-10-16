import com.github.britooo.looca.api.core.Looca

open class Main {
    companion object {
        @JvmStatic
        fun main(args: Array<String>) {
            println("Olá! Seja bem-vindo à Sparrow Tech Solutions. \nEstamos aqui para ajudá-lo a capturar os pacotes de rede e monitorar sua conexão.")
            print("Pronto para começar? Digite 1 para iniciar: ")

            val inicio = readln().toInt()

            if (inicio == 1) {
                val repositorio = MaquinaRepositorio()
                repositorio.configurar()
                val looca = Looca()
                var interfaces = looca.rede.grupoDeInterfaces.interfaces
                val existeMac = repositorio.existePorMac(interfaces[0].enderecoMac)
                if (existeMac) {
                    println("Máquina já cadastrada. Iniciando captura...")
                } else {

                    val novaMaquina = Maquina()
                    novaMaquina.setEnderecoMac(interfaces[0].enderecoMac)
                    repositorio.cadastrarMaquina(novaMaquina)

                    val maquinaCadastrada = repositorio.buscarPorMac(interfaces[0].enderecoMac)

                    repositorio.cadastrarComponente(maquinaCadastrada.id, 4)
                    repositorio.cadastrarComponente(maquinaCadastrada.id, 5)
                    println("Cadastrando máquina no sistema. Iniciando captura...")

                }

                while (true) {
                    interfaces = looca.rede.grupoDeInterfaces.interfaces

                    if (interfaces.isNotEmpty()) {
                        val pacotesEnviados = interfaces[0].pacotesEnviados
                        val pacotesRecebidos = interfaces[0].pacotesRecebidos
                        val maquina = repositorio.buscarPorMac(interfaces[0].enderecoMac)
                        val dadoPacotesEnviados = DadoCapturado().apply {
                            setFkMaquina(maquina.id)
                            setRegistro(pacotesEnviados)
                            setComponenteMaquina(4)
                        }
                        val sucessoEnviados = repositorio.inserir(dadoPacotesEnviados)

                        val dadoPacotesRecebidos = DadoCapturado().apply {
                            setFkMaquina(maquina.id)
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
                        Thread.sleep(10000)
                    }

                }
            } else {
                println("Opção inválida.")
            }

        }
    }
}

