
mkdir osrm
cd osrm

echo "build osrm-backend"
git clone https://github.com/Project-OSRM/osrm-backend.git
cd osrm-backend
sudo docker build . -f docker/Dockerfile -t osrm-backend-latest
cd ../..

echo "make truck docker"
sudo docker build . -f ./dockerfile -t osrm-backend-lvx

cd osrm
echo "download map"
cd ..
mkdir map
cd map
wget https://download.geofabrik.de/europe/italy-latest.osm.pbf

echo "process map"
mkdir truck
cp italy-latest.osm.pbf truck
cd truck
sudo docker run -t -v "${PWD}:/data" osrm-backend-lvx osrm-extract -p /opt/truck.lua /data/italy-latest.osm.pbf
sudo docker run -t -v "${PWD}:/data" osrm-backend-lvx osrm-partition /data/italy-latest.osrm
sudo docker run -t -v "${PWD}:/data" osrm-backend-lvx osrm-customize /data/italy-latest.osrm
rm italy-latest.osm.pbf
cd ..

mkdir car
cp italy-latest.osm.pbf car
cd car
sudo docker run -t -v "${PWD}:/data" osrm-backend-latest osrm-extract -p /opt/car.lua /data/italy-latest.osm.pbf
sudo docker run -t -v "${PWD}:/data" osrm-backend-latest osrm-partition /data/italy-latest.osrm
sudo docker run -t -v "${PWD}:/data" osrm-backend-latest osrm-customize /data/italy-latest.osrm
rm italy-latest.osm.pbf
cd ..

echo "start osrm backend"
sudo docker run -d -t -i -p 5000:5000 -v "${PWD}:/data" osrm-backend-latest osrm-routed --algorithm mld /data/truck/italy-latest.osrm
sudo docker run -d -t -i -p 5001:5000 -v "${PWD}:/data" osrm-backend-latest osrm-routed --algorithm mld /data/car/italy-latest.osrm

cd ../..
echo "install frontend"
git clone https://github.com/luca-saggese/osrm-frontend.git
cd osrm-frontend
sudo docker build . -f docker/Dockerfile -t osrm-frontend-lvx
echo "start frontend"
sudo docker run -p 9966:9966 osrm-frontend-lvx