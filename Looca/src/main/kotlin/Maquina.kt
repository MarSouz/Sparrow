class Maquina {
    var id: Int = 0
    var fk_empresa: Int = 1
    var fk_tipo_maquina: Int = 1
    var endereco_mac: String = ""
        private set

    fun setEnderecoMac(novoValor: String) {
        endereco_mac = novoValor
    }
}