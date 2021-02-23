# SQL-Zagros
A sample SQL OLTP database for a fictional travel agency. <br />

# Recommended Prerequisites
1-https://github.com/Afsarsoft/SQL101 <br />
2-https://github.com/Afsarsoft/SQL-AnimalShelter <br />
3-https://github.com/Afsarsoft/SQL-Game <br />

# Manual Installation 
1- In a new or existing SQL DB or Azure SQL DB, from "Script1" folder, install script CreateSchema.sql <br />
2- From "SP" folder install all SPs (ignore any warnings) <br />
3- From "Script2" folder, run all scripts starting with 01_% to 09_% <br />

# Automated Installation 
1- Create a folder "C:\zagros" <br />
2- Copy folders "Script1", "Script2" and "SP" in folder "C:\zagros" <br />
3- For SQL DB, change connection "DB_Connection" according to your environment and Run SSIS package BuildZagrosDB <br />
3- For Azure SQL DB, change connection "AzureDB_Connection" according to your environment and Run SSIS package BuildZagrosDBAzure <br />
