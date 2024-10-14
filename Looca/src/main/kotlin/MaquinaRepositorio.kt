import org.apache.commons.dbcp2.BasicDataSource
import org.springframework.jdbc.core.JdbcTemplate


class MaquinaRepositorio() //(private val jdbcTemplate: JdbcTemplate)
 {

         lateinit var jdbcTemplate: JdbcTemplate
         fun configurar() {
             val dataSource = BasicDataSource()
             dataSource.driverClassName = "com.mysql.cj.jdbc.Driver"
             dataSource.url = "jdbc:mysql://localhost:3306/Sparrow"
             dataSource.username = "root"
             dataSource.password = "manu"

             jdbcTemplate = JdbcTemplate(dataSource);
         }


    fun inserir(novoDado: DadoCapturado): Boolean {
        val qtdLinhasAfetadas = jdbcTemplate.update(
            "INSERT INTO dado_capturado(registro, data_hora, fk_maquina, fk_componente_maquina) " +
                    "values(?,current_timestamp(),1,?)",
            novoDado.registro,
            novoDado.fk_componente_maquina
        )
        return qtdLinhasAfetadas > 0
    }


 }
