import psutil
import time
from mysql.connector import connect, Error
from datetime import datetime

config = {
  'user': 'root',
  'password': 'manu',
  'host': 'localhost',
  'database': 'Sparrow'
}

idEmpresa = 3
idMaquina = 0  
breakMsgSlackCpu = 0
breakMsgSlackRam = 0
breakMsgSlackHd = 0
textoMensagem = ""
msgAlerta = ""

def get_mac_address(interface_name='wlan2'):
    addrs = psutil.net_if_addrs()
    if interface_name in addrs:
        for addr in addrs[interface_name]:
            if addr.family == psutil.AF_LINK:
                return addr.address
    return None

mac_address = get_mac_address('wlan0')  # ou 'wlan0' para Wi-Fi
print(f"MAC Address: {mac_address}")

def mudarBreakSlackCpu():
    global breakMsgSlackCpu
    print("Esperando por 20 segundos CPU") 
    time.sleep(20)
    breakMsgSlackCpu = 0
    
def mudarBreakSlackRam():
    global breakMsgSlackRam
    print("Esperando por 20 segundos RAM") 
    time.sleep(20)
    breakMsgSlackRam = 0
    
def mudarBreakSlackHd():
    global breakMsgSlackHd
    print("Esperando por 20 segundos HD") 
    time.sleep(20)
    breakMsgSlackHd = 0
    



try:
        db = connect(**config)
        if db.is_connected():
            db_info = db.get_server_info()
            print('Connected to MySQL server version -', db_info)
                    
            with db.cursor() as cursor:
                query1 = (f"SELECT * FROM maquina WHERE endereco_mac = '{mac_address}'")
                        
                cursor.execute(query1)
                    
                
                result = cursor.fetchone()
                print(result)
                    
            cursor.close()
            db.close()

except Error as e:
    print('Error to connect with MySQL -', e) 


print(result)
tamanho = len(result)


if(tamanho > 0):
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
                            f"(default, {cpu}, current_timestamp(), {result[0]}, 1)")
                    query2 = ("INSERT INTO Sparrow.dado_capturado VALUES "
                            f"(default, {ram}, current_timestamp(), {result[0]}, 2)")
                    
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
                            f"(default, {disk}, current_timestamp(), {result[0]}, 3)")
                    
                    cursor.execute(query1)
                    db.commit()
                    print(cursor.rowcount, "registro inserido")
                
                cursor.close()
                db.close()

        except Error as e:
            print('Error to connect with MySQL -', e) 
        i += 1
        a = 0

def verificarLimite():
    global breakMsgSlackCpu
    global breakMsgSlackRam
    global breakMsgSlackHd
    global breakMsgSlackRede
    global textoMensagem
    global msgAlerta 

    try:
        db = connect(**config)
        if db.is_connected():
            db_info = db.get_server_info()
            print('Connected to MySQL server version -', db_info)
            
            with db.cursor() as cursor:
                query = ("select * from vw_servidor_card where id_servidor = %s")
                value = [idMaquina] 
                cursor.execute(query, value)
                resultado = cursor.fetchall()  # Obter o primeiro resultado
                
                if resultado:
                    
                    horario_atual = datetime.now()

                    # Formatar a data e hora
                    horario_formatado = horario_atual.strftime("%Y-%m-%d %H:%M:%S")

                    # Exibir o horário formatado
                    print("Horário atual formatado:", horario_formatado)

                    print(resultado)
                    for linha in resultado:
                        
                        # Suponha que sua tabela tenha as colunas 'id', 'nome' e 'endereco'
                        cpu = linha[6] if linha[6] is not None else 0.0
                        limiteCpu = linha[8] if linha[8] is not None else 0.0
                        
                        ram = linha[9] if linha[9] is not None else 0.0
                        limiteRam = linha[11] if linha[11] is not None else 0.0
                        
                        hd = linha[12] if linha[12] is not None else 0.0
                        limiteHd = linha[14] if linha[14] is not None else 0.0
                        
                        rede = linha[15] if linha[15] is not None else 0.0
                        limiteRede = linha[17] if linha[17] is not None else 0.0
                        
                        apelido = linha[3] if linha[3] is not None else "sem identificação"
                        funcao = linha[4] if linha[4] is not None else "Sem função"

                    
                        print(f"Antes do if valor  CPU {cpu} --- Limite de CPU {limiteCpu}")
                        if cpu > limiteCpu and breakMsgSlackCpu == 0:
                            textoMensagem = f"O servidor com identificador {apelido} e função de {funcao} superou o limite de {limiteCpu}%, com um uso atual de {cpu}% - superado em {horario_formatado}   "
                            enviarMensagem(textoMensagem)
                            breakMsgSlackCpu = 1
                            threading.Thread(target=mudarBreakSlackCpu).start()
                            msgAlerta = f"limite de {limiteCpu} foi superado em {cpu}%"
                            threading.Thread(target=inserirAlerta(horario_formatado)).start()
                            
                        else:
                            print(f"Não foi possivel CPU - var de break = {breakMsgSlackCpu}")
                            
                            
                            
                            
                            
                            
                        if ram > limiteRam and breakMsgSlackRam == 0:
                            textoMensagem = f"O servidor com identificador {apelido} e função de {funcao} superou o limite de {limiteRam}%, com um uso atual de {ram}% - superado em {horario_formatado}   "
                            enviarMensagem(textoMensagem)
                            breakMsgSlackRam = 1
                            threading.Thread(target=mudarBreakSlackRam).start()
                            msgAlerta = f"limite de {limiteRam} foi superado em {ram}%"
                            threading.Thread(target=inserirAlerta(horario_formatado)).start()
                        else:
                            print(f"Não foi possivel RAM - var de break = {breakMsgSlackRam}")
                            
                        if hd > limiteHd and breakMsgSlackHd == 0:
                            textoMensagem = f"O servidor com identificador {apelido} e função de {funcao} superou o limite de {limiteRam}%, com um uso atual de {ram}% - superado em {horario_formatado}   "
                            enviarMensagem(textoMensagem)
                            breakMsgSlackHd = 1
                            threading.Thread(target=mudarBreakSlackHd).start()
                            msgAlerta = f"limite de {limiteHd} foi superado, Gb atual {hd}%"
                            threading.Thread(target=inserirAlerta(horario_formatado)).start()
                        else:
                            print(f"Não foi possivel hd - var de break = {breakMsgSlackHd}")
                        
                        print(f"Antes do if valor  CPU {rede} --- Limite de CPU {limiteRede}")
                        if rede > limiteRede and breakMsgSlackRede == 0:
                            textoMensagem = f"O servidor com identificador {apelido} e função de {funcao} superou o limite de {limiteRam}%, com um uso atual de {ram}% - superado em {horario_formatado}   "
                            enviarMensagem(textoMensagem)
                            breakMsgSlackRede = 1
                            threading.Thread(target=mudarBreakSlackRede).start()
                            threading.Thread(target=inserirAlerta(horario_formatado)).start()
                        else:
                            print(f"Não foi possivel REDE - var de break = {breakMsgSlackRede}")
                    else:
                        print("Sem resultado")
            
                cursor.close()
                db.close()
                

    except Error as e:
        print('Error to connect with MySQL -', e)

import requests
import json

# Substitua pela sua URL do Webhook
webhook_url = ""

def enviarMensagem(texto):
    message = {
        "text": texto
    }

    try:
        response = requests.post(webhook_url, data=json.dumps(message),
                                headers={'Content-Type': 'application/json'})
        if response.status_code == 200:
            print("Mensagem enviada com sucesso!")
        else:
            print(f"Erro ao enviar mensagem: {response.status_code} - {response.text}")

    except requests.exceptions.RequestException as e:
        print(f"Erro ao enviar mensagem: {e}")