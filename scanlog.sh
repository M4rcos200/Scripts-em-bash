#!/bin/bash

trap "echo -e '\nInterrompido pelo usuario.'; exit" SIGINT

#!/bin/bash
echo "███████╗ ██████╗ █████╗ ███╗   ██╗     ██╗      ██████╗  ██████╗ "
echo "██╔════╝██╔════╝██╔══██╗████╗  ██║     ██║     ██╔═══██╗██╔═══██╗"
echo "███████╗██║     ███████║██╔██╗ ██║     ██║     ██║   ██║██║   ██║"
echo "╚════██║██║     ██╔══██║██║╚██╗██║     ██║     ██║   ██║██║   ██║"
echo "███████║╚██████╗██║  ██║██║ ╚████║     ███████╗╚██████╔╝╚██████╔╝"
echo "╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝     ╚══════╝ ╚═════╝  ╚═════╝ "
echo "                        Scan-Log"


   echo "Modo de Uso"
   echo "./script.sh opcao"
   echo "./script.sh -a"
   echo ""
   echo " a - Detectar possíveis ataques de XSS (Cross-Site Scripting)"
   echo " b - Detectar tentativas de SQL Injection"
   echo " c - Detectar varredura de diretórios (Directory Traversal)"
   echo " d - Detectar possíveis ataques por scanners (User-Agent suspeito)"
   echo " e - Identificar tentativas de acesso a arquivos sensíveis (.env, .git, etc.)"
   echo " m - Detectar possíveis ataques de força bruta a arquivos/pastas"
   echo " g - Primeiro e ultimo acesso de um IP suspeito."
   echo " h - Localizar user-agent utilizado por um IP suspeito"
   echo " i - Listar os ips e verificar o numero de requisições"
   echo " j - Localizar acesso a um determinado arquivo sensível"
   echo ""
   echo ""

banner2()
{
  echo "Scan-Log  - version 0.1"
  echo "Marcos"
  echo ""
  echo ""
}

banner2

if [ "${1}" = "-a" ]
then
	echo "Digite o arquivo .log:"
		read arquivo

	if [[ -f "$arquivo" ]]; then
		grep -iE "<script|%3Cscript" $arquivo
    
	else
		echo "Arquivo não encontrado!"
	fi
	

elif [ "${1}" = "-b" ]
then

    echo "Digite o arquivo .log:"
		read arquivo

	if [[ -f "$arquivo" ]]; then
		grep -iE "union|select|insert|drop|%27|%22" $arquivo
    
	else
		echo "Arquivo não encontrado!"
	fi
    

elif [ "${1}" = "-c" ]
then

    echo "Digite o arquivo .log:"
		read arquivo

	if [[ -f "$arquivo" ]]; then
		grep -E "\.\./|\.\.%2f" $arquivo
    
	else
		echo "Arquivo não encontrado!"
	fi

elif [ "${1}" = "-d" ]
then

    echo "Digite o arquivo .log:"
		read arquivo

	if [[ -f "$arquivo" ]]; then
		grep -iE "nikto|nmap|sqlmap|acunetix|curl|masscan|python" $arquivo
    
	else
		echo "Arquivo não encontrado!"
	fi

elif [ "${1}" = "-e" ]
then

    echo "Digite o arquivo .log:"
		read arquivo

	if [[ -f "$arquivo" ]]; then
		grep -iE "\.env|\.git|\.htaccess|\.bak" $arquivo
    
	else
		echo "Arquivo não encontrado!"
	fi

elif [ "${1}" = "-m" ]
then

    echo "Digite o arquivo .log:"
    read arquivo

	if [[ -f "$arquivo" ]]; then
		grep " 404 " $arquivo | cut -d " " -f 1 | sort | uniq -c | sort -nr | head
    
	else
		echo "Arquivo não encontrado!"
	fi
	
elif [ "${1}" = "-g" ]
then

    echo "Digite o arquivo .log:"
		read arquivo

	if [[ -f "$arquivo" ]]; then
		echo "Digite o IP - Ex: 192.168.0.1"
		read ip
		grep $ip access.log | head -n1
		grep $ip access.log | tail -n1
    
	else
		echo "Arquivo não encontrado!"
	fi
 
elif [ "${1}" = "-h" ]
then

echo "Digite o arquivo .log:"
		read arquivo

	if [[ -f "$arquivo" ]]; then
		echo "Digite o IP - Ex: 192.168.0.1"
		read ip
		grep $ip access.log | cut -d '"' -f 6 | sort | uniq
    
	else
		echo "Arquivo não encontrado!"
	fi

elif [ "${1}" = "-i" ]
then

    echo "Digite o arquivo .log:"
		read arquivo

	if [[ -f "$arquivo" ]]; then
		cat $arquivo | cut -d " " -f 1 | sort | uniq -c
    
	else
		echo "Arquivo não encontrado!"
	fi
	
elif [ "${1}" = "-j" ]
then
	echo "Digite o arquivo .log:"
	read arquivo
	
	echo "Digite o nome do possivel arquivo senssivel: "
	read nome

	if [[ -f "$arquivo" ]]; then
           echo -e "\n Buscando por: \"$nome\" no arquivo \"$arquivo\"...\n"

		grep "$nome" "$arquivo"
		
		if [[ $? -eq 0 ]]; then
			echo -e "\n Termo encontrado!"
		else
			echo -e "\n Nada encontrado"
		fi
    
	else
		echo "Arquivo não encontrado!"
	fi

fi

