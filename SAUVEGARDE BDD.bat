@echo off

set database = movietheaterbooking
set username = admin_odyssee
set directory = "c:/studi/bdd.sql"

pg_dump -d %database%  -U %username% -f %directory% -w -Fp