import psutil
import time
from mysql.connector import connect, Error

config = {
    'user': 'root',
    'password': '280406',
    'host': 'localhost',
    'database': 'Sparrow'
}

def get_mac_address(interface_name='wlan2'):
    addrs = psutil.net_if_addrs()
    if interface_name in addrs:
        for addr in addrs[interface_name]:
            if addr.family == psutil.AF_LINK:
                return addr.address
    return None

mac_address = get_mac_address('wlan0')  # ou 'wlan0' para Wi-Fi
print(f"MAC Address: {mac_address}")

try:
    db = connect(**config)
    if db.is_connected():
        db_info = db.get_server_info()
        print('Connected to MySQL server version -', db_info)

        with db.cursor() as cursor:
            query1 = f'SELECT * FROM maquina WHERE endereco_mac = "c4:bd:e5:1e:a9:1a"'
            cursor.execute(query1)
            result = cursor.fetchone()
            print(result[0])

        cursor.close()
        db.close()

except Error as e:
    print('Error to connect with MySQL -', e)

print(result)
tamanho = len(result)

if tamanho > 0:
    i = 0
    a = 0
    while i < 10:
        while a < 10:
            # Captura de CPU e RAM
            cpu = psutil.cpu_percent(interval=None, percpu=False)
            ram = psutil.virtual_memory().percent

            print(f"Uso da CPU: {cpu}%")
            print(f"Uso da RAM: {ram}%")

            try:
                db = connect(**config)
                if db.is_connected():
                    db_info = db.get_server_info()
                    print('Connected to MySQL server version -', db_info)

                with db.cursor() as cursor:
                    # Inserção no banco de dados
                    cursor.execute(
                    f"INSERT INTO Sparrow.dado_capturado (registro, data_hora, fk_empresa, fk_maquina, fk_dado_monitorado) "
                    f"VALUES ({cpu}, current_timestamp(), 1, {result[0]}, 1)"
                    )
                    cursor.execute(
                    f"INSERT INTO Sparrow.dado_capturado (registro, data_hora, fk_empresa, fk_maquina, fk_dado_monitorado) "
                    f"VALUES ({ram}, current_timestamp(), 1, {result[0]}, 2)"
                    )
                    db.commit()
                    print(cursor.rowcount, "registro(s) inserido(s)")

                cursor.close()
                db.close()

            except Error as e:
                print('Error to connect with MySQL -', e)

            a += 1
            time.sleep(1)

        # Captura da porcentagem de uso do disco
        disk = psutil.disk_usage("/").percent

        print('------------------------------------')
        print(f"Porcentagem de uso do disco: {disk}%")

        try:
            db = connect(**config)
            if db.is_connected():
                db_info = db.get_server_info()
                print('Connected to MySQL server version -', db_info)

            with db.cursor() as cursor:
                cursor.execute(
                    f"INSERT INTO Sparrow.dado_capturado (registro, data_hora, fk_empresa, fk_maquina, fk_dado_monitorado) "
                    f"VALUES ({disk}, current_timestamp(), 1, {result[0]}, 3)"
                )
                db.commit()
                print(cursor.rowcount, "registro inserido")

            cursor.close()
            db.close()

        except Error as e:
            print('Error to connect with MySQL -', e)

        i += 1
        a = 0
