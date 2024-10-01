import psutil
import time
import subprocess
from datetime import datetime
from mysql.connector import connect, Error

config = {
  'user': 'root',
  'password': 'manu',
  'host': 'localhost',
  'database': 'calculo',
  'auth_plugin': 'mysql_native_password'
}


while (True):

    datahora = datetime.now()
    dt= datahora.strftime("%d/%m/%Y")
    dthora = datahora.strftime("%d/%m/%Y %H:%M:%S")
    
    cpu_percent = psutil.cpu_percent(interval=1)

    mem = psutil.virtual_memory()
    utilizado_ram = mem.used
    disco = psutil.disk_usage('/')
    utilizado_armazenamento = disco.used
    redeenvio = psutil.net_io_counters()[2]
    rederecebimento = psutil.net_io_counters()[3]
    boot = datetime.fromtimestamp(psutil.boot_time()).strftime("%Y-%m-%d %H:%M:%S")
    boot_time = datetime.fromtimestamp(psutil.boot_time())
    uptime = datetime.now() - boot_time
    
    print(dthora)
    print(f"CPU utilizada: {cpu_percent}%")
    print(f"RAM utilizada: {utilizado_ram / (1024 ** 3):.2f} GB")
    print(f"DISCO utilizado: {utilizado_armazenamento / (1024 ** 3):.2f} GB")
    print(f"pacotes enviados: {redeenvio}")
    print(f"pacotes recebidos: {rederecebimento}")
    print(f"tempo de boot: {boot}")
    print("------------------------------")
    
    try:
        db = connect(**config)

        
        if db.is_connected():
            db_info = db.get_server_info()
            print('Connected to MySQL server version -', db_info)
            
            with db.cursor() as cursor:
                query = ("INSERT INTO calculo.dados_capturados VALUES "
                        f"(null, current_timestamp(), {cpu_percent}, {utilizado_ram / 1024/1024/1024}, {utilizado_armazenamento / 1024 / 1024 / 1024}, {redeenvio})")
                cursor.execute(query)
                db.commit()
                print(cursor.rowcount, "registro inserido")
            
            cursor.close()
            db.close()

    except Error as e:
        print('Error to connect with MySQL -', e) 

    time.sleep(10)
   
