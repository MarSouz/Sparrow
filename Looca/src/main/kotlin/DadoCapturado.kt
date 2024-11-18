import java.util.Date

class DadoCapturado() {
    var id: Int = 0

    var registro: Long = 0
        private set

    var fk_maquina: Int = 0
        private set

    var fk_componente_maquina: Int = 0
        private set

    var fk_empresa:Int = 0
        private set

    fun setFkEmpresa(novoValor: Int){
        fk_empresa = novoValor
    }

    fun setRegistro(novoValor: Long){
        registro = novoValor
    }

    fun setComponenteMaquina(novoValor: Int){
        fk_componente_maquina = novoValor
    }

    fun setFkMaquina(novoValor: Int){
        fk_maquina = novoValor
    }
}