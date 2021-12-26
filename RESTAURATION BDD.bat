@echo off

set database=movietheaterbooking
set username=admin_odyssee
set directory="c:/studi/bdd.sql"

psql -U %username%  -d %database% < %directory%