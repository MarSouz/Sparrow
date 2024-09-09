import psutil
import time
import subprocess
from datetime import datetime



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
    print(f"Tempo que o computador está ligado: {str(uptime).split('.')[0]}")
    print("------------------------------")

    time.sleep(10)
   
