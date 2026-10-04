@echo off
echo Levantando Contenedores Docker (CakePHP en http://localhost:8765 y MariaDB en 3306)...
docker compose up -d
echo Contenedores activos:
docker compose ps
echo Abre http://localhost:8765 o http://localhost:8765/students
pause
