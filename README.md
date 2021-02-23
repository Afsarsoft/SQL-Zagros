# SQL-Zagros
A SQL OLTP database for a fictional travel agency.  

# Recommended Prerequisites
1-https://github.com/Afsarsoft/SQL101
2-https://github.com/Afsarsoft/SQL-AnimalShelter
3-https://github.com/Afsarsoft/SQL-Game

# Manual Installation 
1- In a new or existing SQL DB or Azure SQL DB, from "Script1" folder, install script CreateSchema.sql
2- From "SP" folder install all SPs (ignore any warnings)
3- From "Script2" folder, run all scripts starting with 01_% to 09_%

# Automated Installation 
1- Create a folder "C:\zagros"
2- Copy folders "Script1", "Script2" and "SP" in folder "C:\zagros" 
3- For SQL DB, change connection "DB_Connection" according to your environment and Run SSIS package BuildZagrosDB
3- For Azure SQL DB, change connection "AzureDB_Connection" according to your environment and Run SSIS package BuildZagrosDBAzure
