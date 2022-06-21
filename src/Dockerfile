FROM amsterdam/python:3.9-buster
MAINTAINER datapunt@amsterdam.nl

# Install GDAL
RUN apt-get update
RUN apt-get install -y libgdal-dev

# Update C env vars so compiler can find gdal
ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV C_INCLUDE_PATH=/usr/include/gdal

# Install gdal separately from the rest of the python requirements.
# This avoids that changes to requirements.txt incure a time consuming gdal build
RUN LIBGDAL_VERSION=$(gdal-config --version) && pip install GDAL==${LIBGDAL_VERSION}
