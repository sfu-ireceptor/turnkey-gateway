# iReceptor Gateway Turnkey

A "dockerized" iReceptor Gateway (:warning: alpha version).

## System requirements

- Linux Ubuntu (tested on Ubuntu 16.04)
- `sudo` without password (often already enabled on virtual machines).
 
## Installation

Download this repository:

```
git clone https://github.com/sfu-ireceptor/turnkey-gateway.git
```

Create a TSV file with your list of users in the `data` folder. Just copy and edit the example file:

```
cd turnkey-gateway
cp data/users.tsv.example data/users.tsv

vi data/users.tsv

# note: you can add more users after the installation 
```

Launch the installation script. Note: multiple Docker images will be downloaded from DockerHub. Total time estimate: 10-30 min.

```
scripts/install_turnkey.sh
```

## Check it's working

```
curl localhost/login
```

The HTML code of the login page should be displayed.

Then go to <http://localhost> in your browser (replace "localhost" with your server URL if necessary) and log in using one of your users credentials.

## Starting and stopping the Turnkey
This will start and stop the Docker containers:
```
scripts/start_turnkey.sh
```
```
scripts/stop_turnkey.sh


### If something looks wrong
- [Troubleshooting](doc/troubleshooting.md) :hammer:

## Contact us
:envelope: <support@ireceptor.org>