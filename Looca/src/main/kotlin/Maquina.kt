class Maquina {
    var id: Int = 0
    var fk_empresa: Int = 1
    var fk_tipo_maquina: Int = 2
        private set
    var endereco_mac: String = ""
        private set

    fun setEnderecoMac(novoValor: String) {
        endereco_mac = novoValor
    }

    fun setFkTipoMaquina(novoValor: Int){
        fk_tipo_maquina = novoValor
    }
}