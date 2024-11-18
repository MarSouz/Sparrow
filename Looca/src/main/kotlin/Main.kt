import com.github.britooo.looca.api.core.Looca

open class Main {
    companion object {
        @JvmStatic
        fun main(args: Array<String>) {
            val repositorio = MaquinaRepositorio()
            repositorio.configurar()
            val looca = Looca()
            while (true) {
                val interfaces = looca.rede.grupoDeInterfaces.interfaces
                val interfaceDeConexaoPrincipal = interfaces.filter { it.nome.lowercase().contains("wlan2") };
                println(interfaceDeConexaoPrincipal[0].pacotesEnviados)
                if (interfaces.isNotEmpty()) {
                    val pacotesEnviados = interfaceDeConexaoPrincipal[0].pacotesEnviados
                    val pacotesRecebidos = interfaceDeConexaoPrincipal[0].pacotesRecebidos
                    val maquina = repositorio.buscarPorMac(interfaces[0].enderecoMac)
                    val dadoPacotesEnviados = DadoCapturado().apply {
                        setFkMaquina(maquina.id)
                        setRegistro(pacotesEnviados)
                        setComponenteMaquina(4)
                        setFkEmpresa(maquina.fk_empresa)
                    }
                    val sucessoEnviados = repositorio.inserir(dadoPacotesEnviados)

                    val dadoPacotesRecebidos = DadoCapturado().apply {
                        setFkMaquina(maquina.id)
                        setRegistro(pacotesRecebidos)
                        setComponenteMaquina(5)
                        setFkEmpresa(maquina.fk_empresa)
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

        }
    }
}

