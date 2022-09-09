# syntax=docker/dockerfile:1
FROM amsterdam/python:3.9-buster
MAINTAINER datapunt@amsterdam.nl


# Install GDAL development files.
RUN apt-get update && apt-get install -y libgdal-dev

# Update C env vars so compiler can find GDAL development files.
ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV C_INCLUDE_PATH=/usr/include/gdal

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
