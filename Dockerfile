FROM amsterdam/python:3.9-buster
MAINTAINER datapunt@amsterdam.nl


# Install GDAL development files.
RUN apt-get update && apt-get install -y libgdal-dev

# Update C env vars so compiler can find GDAL development files.
ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV C_INCLUDE_PATH=/usr/include/gdal

# Recent pip.
RUN pip install --upgrade pip

# Install GDAL separately from the rest of the Python requirements.
# This avoids that changes to requirements.txt incure a time consuming GDAL build.
RUN LIBGDAL_VERSION=$(gdal-config --version) && pip install GDAL==${LIBGDAL_VERSION}
