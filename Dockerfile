FROM amsterdam/python:3.9-buster
MAINTAINER datapunt@amsterdam.nl


# SQL Server driver package source.
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list
# Install GDAL development files and SQL Server driver.
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y libgdal-dev msodbcsql17

# Update C env vars so compiler can find GDAL development files.
ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV C_INCLUDE_PATH=/usr/include/gdal

# Recent pip.
RUN pip install --upgrade pip

# Install GDAL separately from the rest of the Python requirements.
# This avoids that changes to requirements.txt incure a time consuming GDAL build.
RUN LIBGDAL_VERSION=$(gdal-config --version) && pip install GDAL==${LIBGDAL_VERSION}
