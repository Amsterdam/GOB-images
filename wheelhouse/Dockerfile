# syntax=docker/dockerfile:1
FROM amsterdam/python:3.9-bullseye
MAINTAINER datapunt@amsterdam.nl


# Install GDAL development files.
RUN apt-get update && apt-get install -y libgdal-dev

# Update C env vars so compiler can find GDAL development files.
ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV C_INCLUDE_PATH=/usr/include/gdal

# Work around (setuptools<58) for GDAL 2.4.0 (error in GDAL setup command: use_2to3 is invalid).
RUN pip install --no-cache-dir setuptools==57.5.0

# Recent pip and wheel.
RUN pip install --upgrade --no-cache-dir pip wheel


# Wheelhouse directory.
WORKDIR /opt/wheelhouse

# Clone GOB-Core (requirements.txt).
RUN git clone --depth=1 https://github.com/Amsterdam/GOB-Core.git

# Build the wheels.
RUN LIBGDAL_VERSION=$(gdal-config --version) pip wheel \
	--no-cache-dir --wheel-dir /opt/wheelhouse \
	--requirement GOB-Core/requirements.txt

# Cleanup GOB-Core repo.
RUN rm -rf /opt/wheelhouse/GOB-Core
