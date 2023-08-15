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

mkdir osrm-data

docker run -t -v "${PWD}:/data" -v "${PWD}/osrm-profiles-truck/5/27/truck:/opt/profile"  osrm/osrm-backend osrm-extract -p /opt/profile/car.lua /data/italy-latest.osm.pbf