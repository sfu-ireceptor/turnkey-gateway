# iReceptor Gateway Turnkey

A "dockerized" iReceptor Gateway.

:warning: It's an alpha version with the current limitations:
- long downloads will time out
- user pages (user list, user profile) are not working

## System requirements

- Linux Ubuntu (tested on Ubuntu 16.04)
- `sudo` without password (often already enabled on virtual machines).

Note: this turnkey is a quick and easy way to get a gateway up and running on a VM running Linux Ubuntu. You could instead do the installation manually on a different system, by following the Docker files instructions and adapting them accordingly.
 
## Installation

### Download this repository

```
git clone https://github.com/sfu-ireceptor/turnkey-gateway.git
```

### Create a TSV file with your list of users

Copy and edit the example file:

```
cd turnkey-gateway
cp data/users.tsv.example data/users.tsv

vi data/users.tsv 
```

Note: more users can be added later.

### Execute the installation script.

Multiple Docker images will be downloaded from DockerHub, so this might take up to 30 min.

```
scripts/install_turnkey.sh
```

## Check it's working

Replace "localhost" with your server URL if necessary:

```
curl localhost/login
```

The HTML code of the login page should be displayed.

Then go to that URL <http://localhost/login> in your browser and log as one of your previously defined users. Note: in this alpha version, the password is not actually verified.


## Starting and stopping the Turnkey
```
scripts/start_turnkey.sh
```
```
scripts/stop_turnkey.sh
```

These scripts start and stop the Docker containers.

## Adding more users

Edit `data/users.tsv`, then run:

```
scripts/load_users.sh
```

Note: existing users (with a username already in the database) will be updated, not duplicated.

## Adding repositories

Your gateway comes preloaded with public AIRR repositories. To add more repositoires, create `private_rest_services.tsv`:

```
cp data/private_rest_services.tsv.example data/private_rest_services.tsv
```

Edit it (and remove the two examples it contains). Make sure your repositories URLs end with `/airr/v1/` (don't forget the trailing slash!).

Then run:

```
scripts/load_private_repositories.sh
```

Note: existing repositories (with a URL already in the database) will be updated, not duplicated.


Your repositories will be enabled by default. Go to http://localhost/admin/databases (replace localhost by your server name).

Check your repositories are enabled, and for each one, refresh the cached sequence counts and max_size/stats. Also, at the bottom of the page, click "Refresh cached repertoire metadata". Then go to the repertoires page and check your repository data is displayed properly: http://localhost/samples


## Other information

### If something looks wrong
- [Troubleshooting](doc/troubleshooting.md) :hammer:

## Contact us
:envelope: <support@ireceptor.org>