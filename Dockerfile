FROM amsterdam/python:3.9-buster
MAINTAINER datapunt@amsterdam.nl


# SQL Server driver package source.
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list
# Install Microsoft ODBC Driver for SQL Server.
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql17

# Recent pip.
RUN pip install --upgrade pip
