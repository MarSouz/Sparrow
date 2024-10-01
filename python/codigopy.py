import psutil
import time
from mysql.connector import connect, Error

config = {
  'user': 'root',
  'password': '#Gf23636497880',
  'host': 'localhost',
  'database': 'Sparrow'
}


qtdCpu = psutil.cpu_count(logical=True)

bytes = 1073741824
qtdRam = psutil.virtual_memory()[0] / bytes
ramFormatada = "{:.1f}".format(qtdRam)

qtdDisco = psutil.disk_usage("/")[0] / bytes
discoFormatado = "{:.1f}".format(qtdDisco)

print(f"Quantidade total de CPUs: {qtdCpu}")
print(f"Quantidade total de RAM: {ramFormatada}Gib")
print(f"Quantidade total de Disco: {discoFormatado}Gib")


i = 0
a = 0
while i < 10: 
    while a < 10:
        cpu = psutil.cpu_percent(interval=None, percpu=False)        

        ram = psutil.virtual_memory()[2]
    
        print(f"Uso da CPU: {cpu}%")
        print(f"Uso da RAM: {ram}%")

        try:
            db = connect(**config)
            if db.is_connected():
                db_info = db.get_server_info()
                print('Connected to MySQL server version -', db_info)
            
            with db.cursor() as cursor:
                query1 = ("INSERT INTO Sparrow.dado_capturado VALUES "
                        f"(null, {cpu}, current_timestamp(), 1, 1)")
                query2 = ("INSERT INTO Sparrow.dado_capturado VALUES "
                        f"(null, {ram}, current_timestamp(), 1, 2)")
                
                cursor.execute(query1)
                cursor.execute(query2)
                db.commit()
                print(cursor.rowcount, "registro inserido")
            
            cursor.close()
            db.close()

        except Error as e:
            print('Error to connect with MySQL -', e) 

        a += 1
        i = 0
        time.sleep(1)

    disk = psutil.disk_usage("/")[3]

    print('------------------------------------')
    print(f"Espaço de disco disponível: {disk}%")

    try:
            db = connect(**config)
            if db.is_connected():
                db_info = db.get_server_info()
                print('Connected to MySQL server version -', db_info)
            
            with db.cursor() as cursor:
                query1 = ("INSERT INTO Sparrow.dado_capturado VALUES "
                        f"(null, {disk}, current_timestamp(), 1, 3)")
                
                cursor.execute(query1)
                db.commit()
                print(cursor.rowcount, "registro inserido")
            
            cursor.close()
            db.close()

    except Error as e:
        print('Error to connect with MySQL -', e) 
    i += 1
    a = 0

    
    
    

