#!/bin/bash

# ============================================================
#  NOMBRE: AutoYara Deep Hunter v2.0
#  ID:nanobug8
#  DESCRIPCION: Busca recursivamente todas las reglas .yar y escanea
# ============================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

if [ -z "$1" ]; then
    echo -e "${RED}[!] Error: Falta la ruta de la evidencia.${NC}"
    echo "Uso: ./hunter.sh /ruta/a/la/evidencia_montada"
    exit 1
fi

EVIDENCIA=$1
FECHA=$(date +"%Y-%m-%d_%H-%M")
REPORTE="yara_hunter_report_$FECHA.txt"

echo -e "${YELLOW}[*] Iniciando Búsqueda Profunda de Reglas...${NC}"
echo -e "${YELLOW}[*] Evidencia: $EVIDENCIA${NC}"
echo "==================================================" >> $REPORTE
echo "INICIO DE ANALISIS: $(date)" >> $REPORTE

# CAMBIO CLAVE: Usamos 'find' para localizar todos los .yar desde donde estás parado
# Esto alimenta el bucle while. No importa qué tan profundas estén las carpetas.
find . -type f -name "*.yar" | while read regla; do

    # Estética: Sacamos el nombre de la carpeta para mostrarlo bonito
    carpeta_padre=$(dirname "$regla")
    nombre_archivo=$(basename "$regla")
    
    # Solo imprimimos en pantalla para saber que está vivo
    echo -e "${BLUE}[INFO] Carpeta: $carpeta_padre${NC}"
    echo -ne "       -> Probando regla: $nombre_archivo ... "

    # Ejecutamos YARA
    # 2>/dev/null oculta errores técnicos para limpiar la pantalla
    RESULTADO=$(yara -w -r "$regla" "$EVIDENCIA" 2>/dev/null)

    if [ -z "$RESULTADO" ]; then
        echo "Limpio."
    else
        echo -e "${RED} [!] DETECCION [!] ${NC}"
        
        # Guardamos en reporte y mostramos en pantalla
        echo "----------------------------------------" >> $REPORTE
        echo "[ALERTA] Regla: $regla" >> $REPORTE
        echo "$RESULTADO" >> $REPORTE
        
        # Mostramos en rojo en la terminal
        echo -e "${RED}$RESULTADO${NC}"
    fi

done

echo -e "\n${YELLOW}[*] Análisis finalizado. Revisa $REPORTE${NC}"
