# Soundscape Backend Overview

The backend of Soundscape consists of three parts:

1. Ingestion service that takes data from Open Street Maps in .pbf form and transforms to PostGIS format.
2. PostgreSQL database with PostGIS extension installed to store the output of the Ingestion service.
3. Tile service that allows the database to be queried and outputs a .json file in GeoJSON format.

If you want to have a local dev environment running in Docker. Then clone the repo, navigate to soundscape/svcs/data/ and from a terminal: 

docker compose up

This will spin up a stack containing three Docker containers with the services described above. You can do a quick test that it is working by using a browser/curl/whatever to hit the Tile service which is listening on 8080 and it should spit out a GeoJSON file for the Washington Capitol Building: 

http://localhost:8080/16/18748/25072.json

# Ingestion Service Details

The Ingestion service is a Python file (ingest.py) which gets Open Street Map data and transform it into PostGIS format using the Imposm program and then connects to the PostgreSQL database using aiopg and writes the data to the db.

The Open Street Map data can be in the form of a singular extract (district-of-columbia-latest.osm.pbf) or multiple extracts. The service uses the extracts.json file to know where it needs to get the extracts from. 


# OSM Indexing

These services used IMPOSM (https://github.com/omniscale/imposm3) to
import OSM planet data into PostGIS.  We use IMPOSM's mapping facility
to do light filtering on the OSM data and inject it into the database.

Recently questions have been asked about the maintenance level of
IMPOSM.  We have explored other alternatives.  In our prototyping, it
was possible to configure OSM2PGSQL to produce very similar data as
IMPOSM with the '--output=flex' and an appropriate LUA style.
