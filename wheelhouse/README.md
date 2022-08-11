# wheelhouse

## Buster

* Python 3.9 (`amsterdam/python:3.9-buster`)
* wheels (`/opt/wheelhouse`)

## Usage

Copy wheels from the wheelhouse, run `pip install --find-links /opt/wheelhouse` and delete the wheelhouse directory.

```dockerfile
FROM amsterdam/wheelhouse:buster as wheelhouse
MAINTAINER datapunt@amsterdam.nl


# Application stage.
FROM amsterdam/python:3.9-buster as application
MAINTAINER datapunt@amsterdam.nl

# Install GDAL development files.
RUN apt-get update && apt-get install -y libgdal-dev

# Recent pip and wheel.
RUN pip install --upgrade pip wheel

# Fill the wheelhouse.
COPY --from=wheelhouse /opt/wheelhouse /opt/wheelhouse

# Install service in /app folder
WORKDIR /app

# Install required Python packages.
COPY requirements.txt /app/
RUN LIBGDAL_VERSION=$(gdal-config --version) pip install --no-cache-dir \
	--find-links /opt/wheelhouse --requirement requirements.txt
RUN rm requirements.txt
# Wheelhouse cleanup.
RUN rm -rf /opt/wheelhouse
```

## wheels

GOB-Core wheels (`requirements.txt`).
Among other things:

* [Geospatial Data Abstraction Library](https://gdal.org) (GDAL)
* [Python interface to Oracle](https://cx-oracle.readthedocs.io/) (cx-Oracle)
* [Python-PostgreSQL Database Adapter](https://www.psycopg.org) (psycopg2)
* [Cryptographic library for Python](https://www.pycryptodome.org/) (pycryptodome)
* [DB API Module for ODBC](https://github.com/mkleehammer/pyodbc/wiki/) (pyodbc)
* [Python AMQP Client Library](https://pika.readthedocs.io/) (pika)
* [Implementation of JSON Schema validation for Python](https://python-jsonschema.readthedocs.io/) (jsonschema)
