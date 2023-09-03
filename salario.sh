#!/bin/bash

#---colores
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"
#---end colores

echo -e "\n${grayColour}Hola te ayudaré a calcular los descuentos de tu salario mensual en Panamá menor a 50k Anual${endColour}\n"
read -p "Inserta tu salario neto mensual: " salario

# Variables globales
IrentA=15
Ssocial=9.75
Seducativo=1.25


#operaciones
r_social=$(echo "scale=2; $salario * $Ssocial / 100 " | bc -l)
r_educativo=$(echo "scale=2; $salario * $Seducativo / 100" | bc -l)
r_sumaSE=$(echo "scale=2; $r_social + r_educativo" | bc -l)
#renta menos de 50 mil
r_rentA=$(echo "scale=2; $salario * 13 - 11000" | bc -l)
r_rentAA=$(echo "scale=2; $r_rentA / 13 * $IrentA / 100" | bc -l)

sleep 2s | echo -e "\n${grayColour}Realizando Calculos Necesarios${endColour}\n"

function calculo {
if (( $(echo "$salario <= 1000" | bc -l) )); then
        echo -e "\n${yellowColour}-> Su descuento de seguro Social es de:${endColour} ${redColour}$r_social${endColour}\n"
        echo -e "${yellowColour}-> Su descuento de Seguro educativo es de:${endColour} ${redColour}$r_educativo${endColour}\n"
        quincena=$(echo "scale=2; ($salario - ( $r_social + $r_educativo ))/ 2" | bc -l)
        echo -e "${yellowColour}-> Su pago aproximado por quincena es de:${endColour} ${greenColour}$quincena${endColour}"
elif (( $(echo "$salario >= 1001" | bc -l) )); then
        echo -e "\n${yellowColour}-> Su descuento de impuesto sobre la renta es de:${endColour} ${redColour}$r_rentAA${endColour}"
        echo -e "\n${yellowColour}-> Su descuento de seguro Social es de:${endColour} ${redColour}$r_social${endColour}\n"
        echo -e "${yellowColour}-> Su descuento de Seguro educativo es de:${endColour} ${redColour}$r_educativo${endColour}\n"
        quincenA=$(echo "scale=2; ($salario - ( $r_social + $r_educativo + $r_rentAA))/ 2" | bc -l)
        echo -e "${yellowColour}-> Su pago aproximado por quincena es de:${endColour} ${greenColour}$quincenA${endColour}"
else
        echo -e "\n${redColour}[!] Esta realizando un mal uso del programa${endColour}"
    fi
}

# plan de ahorro e inversion

function pAhorro {
if (( $(echo "$salario <= 1000" | bc -l) )); then
gastos=$(echo "scale=2; $quincena * 50 / 100" | bc -l )
IyA=$(echo "scale=2; $quincena * 30 / 100" | bc -l )
parami=$(echo "scale=2; $quincena * 20 / 100" | bc -l )
        echo -e "\n${yellowColour}-> Aplica el 50% para cubrir tus gastos:${endColour} ${blueColour}$gastos${endColour}"
        echo -e "\n${yellowColour}-> Aplica el 30% para ahorrar e invertir:${endColour} ${grayColour}$IyA${endColour}"
        echo -e "\n${yellowColour}-> Aplica el 20% para consentirte:${endColour} ${greenColour}$parami${endColour}"
elif (( $(echo "$salario >= 1000" | bc -l) )); then
gastos=$(echo "scale=2; $quincenA * 50 / 100" | bc -l )
IyA=$(echo "scale=2; $quincenA * 30 / 100" | bc -l )
parami=$(echo "scale=2; $quincenA * 20 / 100" | bc -l )
        echo -e "\n${yellowColour}-> Aplica el 50% para cubrir tus gastos:${endColour} ${blueColour}$gastos${endColour}"
        echo -e "\n${yellowColour}-> Aplica el 30% para ahorrar e invertir:${endColour} ${grayColour}$IyA${endColour}"
        echo -e "\n${yellowColour}-> Aplica el 20% para consentirte:${endColour} ${greenColour}$parami${endColour}"
else
        echo -e "\n${redColour}[!] Esta realizando un mal uso del programa${endColour}\n"
    fi
}


# Llamamos a la función para realizar los cálculos y mostrar los resultados
calculo

echo -e "\n${grayColour}---> Esto es un plan de administracion financiera que puedes ejecutar en base a tu quincena${endColour}"

pAhorro

echo -e "\nBy -> ADG / MIDESMIS\n"
