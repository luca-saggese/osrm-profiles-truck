
mkdir osrm
cd osrm

echo "build osrm-backend"
git clone https://github.com/Project-OSRM/osrm-backend.git
cd osrm-backend
sudo docker build . -f docker/Dockerfile -t osrm-backend-latest

echo "download map"
cd ..
mkdir map
cd map
wget https://download.geofabrik.de/europe/italy-latest.osm.pbf

echo "make truck docker"
sudo docker build . -f Dockerfile -t osrm-backend-lvx

echo "process map"
mkdir truck
cp italy-latest.osm.pbf truck
cd truck
sudo docker run -t -v "${PWD}:/data" osrm-backend-lvx osrm-extract -p /opt/truck.lua /data/italy-latest.osm.pb
sudo docker run -t -v "${PWD}:/data" osrm-backend-lvx osrm-partition /data/italy-latest.osrm
sudo docker run -t -v "${PWD}:/data" osrm-backend-lvx osrm-customize /data/italy-latest.osrm
rm italy-latest.osm.pbf

mkdir car
cp italy-latest.osm.pbf car
cd car
sudo docker run -t -v "${PWD}:/data" osrm-backend-lvx osrm-extract -p /opt/truck.lua /data/italy-latest.osm.pb
sudo docker run -t -v "${PWD}:/data" osrm-backend-lvx osrm-partition /data/italy-latest.osrm
sudo docker run -t -v "${PWD}:/data" osrm-backend-lvx osrm-customize /data/italy-latest.osrm
rm italy-latest.osm.pbf