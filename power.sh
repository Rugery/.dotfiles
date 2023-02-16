#!/bin/bash

# intervalo de monitoreo en segundos
interval=60

# obtener el estado actual de la batería
current_status=$(cat /sys/class/power_supply/ACAD/online)

# bucle infinito que monitorea el estado de la batería
while :; do
  # obtener el nuevo estado de la batería
  new_status=$(cat /sys/class/power_supply/ACAD/online)
  
  # comparar el estado actual con el nuevo estado
  if [ "$current_status" != "$new_status" ]; then
    # actualizar el estado actual
    current_status=$new_status

    # enviar una notificación según el nuevo estado
    if [ "$new_status" -eq "1" ]; then
      notify-send "Fuente de poder conectada"
    else
      notify-send "Fuente de poder desconectada"
    fi
  fi

  # esperar el intervalo de monitoreo
  sleep $interval
done