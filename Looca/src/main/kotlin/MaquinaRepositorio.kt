import com.sun.rowset.internal.SyncResolverImpl
import org.apache.commons.dbcp2.BasicDataSource
import org.springframework.jdbc.core.BeanPropertyRowMapper
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.jdbc.core.queryForObject


class MaquinaRepositorio() //(private val jdbcTemplate: JdbcTemplate)
 {

         lateinit var jdbcTemplate: JdbcTemplate
         fun configurar() {
             val dataSource = BasicDataSource()
             dataSource.driverClassName = "com.mysql.cj.jdbc.Driver"
             dataSource.url = "jdbc:mysql://localhost:3306/Sparrow"
             dataSource.username = "root"
             dataSource.password = "280406"

             jdbcTemplate = JdbcTemplate(dataSource);
         }


    fun inserir(novoDado: DadoCapturado): Boolean {
        val qtdLinhasAfetadas = jdbcTemplate.update(
            "INSERT INTO dado_capturado(registro, data_hora,fk_empresa, fk_maquina, fk_dado_monitorado) " +
                    "values(?,current_timestamp(),?,?,?)",
            novoDado.registro,
            novoDado.fk_empresa,
            novoDado.fk_maquina,
            novoDado.fk_componente_maquina
        )
        return qtdLinhasAfetadas > 0
    }


     fun existePorMac(enderecoMac:String):Boolean{
         val qtdExistentes = jdbcTemplate.queryForObject(
             "SELECT count(*) FROM maquina WHERE endereco_mac = ?",
             Int::class.java,
             enderecoMac
         )
         return qtdExistentes > 0
     }

     fun cadastrarMaquina(novaMaquina:Maquina):Boolean{
         val qtdLinhasAfetadas = jdbcTemplate.update(
             "INSERT INTO maquina(fk_empresa, fk_tipo_maquina, endereco_mac)"+
                "VALUES(?,?,?)",
             novaMaquina.fk_empresa,
             novaMaquina.fk_tipo_maquina,
             novaMaquina.endereco_mac
         )
         return qtdLinhasAfetadas>0
     }

     fun buscarPorMac(enderecoMac: String): Maquina {
         val maquinaEncontrada = jdbcTemplate.queryForObject(
             "SELECT * FROM maquina WHERE endereco_mac = ?",
             BeanPropertyRowMapper(Maquina::class.java),
             enderecoMac
         )
         return maquinaEncontrada
     }



     fun cadastrarComponente(fkMaquina:Int, fkEmpresa: Int, componente:Int, limite:Int?):Boolean{
         val qtdLinhasAfetadas = jdbcTemplate.update(
             "INSERT INTO maquina_dado_monitorado (fk_maquina, fk_empresa, fk_dado_monitorado, limite_componente)"+
             "VALUES (?,?,?, ?)",
             fkMaquina,
             fkEmpresa,
             componente,
             limite
         )
         return qtdLinhasAfetadas > 0
     }


 }
