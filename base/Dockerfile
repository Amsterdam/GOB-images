# syntax=docker/dockerfile:1
FROM amsterdam/python:3.9-buster
MAINTAINER datapunt@amsterdam.nl


# SQL Server driver package source.
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list
# Install Microsoft ODBC Driver for SQL Server, locales and gdal-config.
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql17 locales locales-all libgdal-dev

WORKDIR /app

# Copy Oracle Instant Client Basic Light Package (ODPI-C driver).
COPY drivers drivers
ENV ORACLE_DIR=/opt/oracle
RUN mkdir -p ${ORACLE_DIR}
RUN unzip drivers/instantclient-basiclite-linux.x64-21.7.0.0.0dbru.zip -d ${ORACLE_DIR}
ENV LD_LIBRARY_PATH=${ORACLE_DIR}/instantclient_21_7:$LD_LIBRARY_PATH
# Install Linux kernel AIO library, ODBC development files, transitional package for HTTPS support.
RUN apt-get -y --no-install-recommends install libaio1 unixodbc-dev apt-transport-https
# Cleanup drivers.
RUN rm -rf /app/drivers

# Prevent decoding issues on systems using different locale.
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# Recent pip and wheel.
RUN pip install --upgrade pip wheel
