#!/bin/bash

# intervalo de monitoreo en segundos
interval=3
# obtener el estado actual de la batería
current_status=$(cat /sys/class/power_supply/AC/online)
BATTERY_LEVEL=$(acpi -b | grep "Battery 0" | grep -P -o '[0-9]+(?=%)')
# bucle infinito que monitorea el estado de la batería
while :; do
  # obtener el nuevo estado de la batería
  new_status=$(cat /sys/class/power_supply/AC/online)

  if [ ! -z "$new_status" ]; then
    # comparar el estado actual con el nuevo estado
    if [ "$current_status" != "$new_status" ]; then
      # actualizar el estado actual
      current_status=$new_status

      # enviar una notificación según el nuevo estado
      if [ "$new_status" -eq "1" ]; then
         notify-send "Charging" "${BATTERY_LEVEL}% of battery charged." -u low -i "battery-charging" -t 5000 -r 9991
      else
       notify-send "Discharging" "${BATTERY_LEVEL}% of battery remaining." -u low -i "battery" -t 5000 -r 9991
      fi
    fi
  fi

  # esperar el intervalo de monitoreo
  sleep $interval
done
