# GOB Base image

## DB drivers
* Microsoft [ODBC Driver for SQL Server](https://docs.microsoft.com/en-us/sql/connect/odbc/microsoft-odbc-driver-for-sql-server) (`msodbcsql18`)
* Oracle [ODPI-C Driver](https://oracle.github.io/odpi/) (Oracle Instant Client)

## Other
* locale `en_US.UTF-8`
* GDAL development files (`libgdal-dev`)
* ODBC development files (`unixodbc-dev`)
* Linux kernel AIO library (`libaio1`)
* Transitional package for HTTPS support (`apt-transport-https`)

## 3.9-bullseye
* Bullseye (`amsterdam/python:3.9-bullseye`)
* Python 3.9.15

## 3.9-slim-bullseye
* Bullseye (`python:3.9-slim-bullseye`)
* Latest Python 3.9.x
