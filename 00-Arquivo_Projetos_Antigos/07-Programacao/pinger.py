import os

   def check_host(ip):
       response = os.system(f"ping -c 1 {ip} > /dev/null 2>&1")
       if response == 0:
           print(f"[+] {ip} está ATIVO")
       else:
           print(f"[-] {ip} está INATIVO")

   if __name__ == "__main__":
       # Teste com seu roteador e seu IP
       ips = ["192.168.1.1", "127.0.0.1"] 
       for ip in ips:
           check_host(ip)
