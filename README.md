# osrm-profiles-contrib

Community-driven routing profiles for [osrm-backend](https://github.com/Project-OSRM/osrm-backend).

Note: these are community-driven adaptions to the [default profiles](https://github.com/Project-OSRM/osrm-backend/tree/master/profiles).

### Overview

Profiles are versioned by OSRM major, then minor version.

```
.
├── 5
│   ├── 5
│   │   └── railway
│   │       └── railway.lua
│   └── 6
│       └── boat
│           └── boat.lua
├── LICENSE
└── README.md
```

### Adding Profiles

- [ ] Fork this repository
- [ ] Add your profile to the versioned subdirectory
- [ ] Make sure to add an explanation and (optional) your mail to the profile
- [ ] Open a Pull Request for review


### License

Copyright © 2016 Project OSRM Contributors

Distributed under the MIT License (MIT).

### How to use

sudo docker pull osrm/osrm-backend

wget https://download.geofabrik.de/europe/italy-latest.osm.pbf

git clone https://github.com/luca-saggese/osrm-profiles-truck.git

cd osrm-profiles-truck

docker build ./ -t osrm/truck

sudo docker run -t -v "${PWD}:/data"   osrm/truck  osrm-extract -p /opt/truck.lua /data/italy-latest.osm.pbf

sudo docker run -t -v "${PWD}:/data" osrm/osrm-backend osrm-partition /data/italy-latest.osrm
sudo docker run -t -v "${PWD}:/data" osrm/osrm-backend osrm-customize /data/italy-latest.osrm


sudo docker run -t -i -p 5000:5000 -v "${PWD}:/data" osrm/osrm-backend osrm-routed --algorithm mld /data/italy-latest.osrm

## Test

Make requests against the HTTP server

curl "http://127.0.0.1:5000/route/v1/driving/13.388860,52.517037;13.385983,52.496891?steps=true"
Optionally start a user-friendly frontend on port 9966, and open it up in your browser

docker run -p 9966:9966 osrm/osrm-frontend
xdg-open 'http://127.0.0.1:9966'
In case Docker complains about not being able to connect to the Docker daemon make sure you are in the docker group.

sudo usermod -aG docker $USER
After adding yourself to the docker group make sure to log out and back in again with your terminal.

docker run -d -t -i -e OSRM_MAPBOX_TOKEN='pk.eyJ1IjoibHZ4IiwiYSI6ImNrZ2o3aXpqcTA2dDIycm52MTBoYzZvdmMifQ.0DteWtdMjx2hXvHikr5RHg' -p 9966:9966 osrm/osrm-frontend



sudo docker run -t -v "${PWD}:/data" osrm-backend-lvx osrm-partition /data/italy-latest.osrm
sudo docker run -t -v "${PWD}:/data" osrm-backend-lvx osrm-customize /data/italy-latest.osrm
