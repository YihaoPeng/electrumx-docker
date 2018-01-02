# electrumx-docker
Dockerfile for [electrumx](https://github.com/kyuupichan/electrumx) on Ubuntu with leveldb and daemontools.

## Usage
### Step 1. Configuration
```
git clone https://github.com/YihaoPeng/electrumx-docker-ubtc.git
cd electrumx-docker-ubtc
```

Then,Edit `env/COIN` to your coin.

Edit `env/DAEMON_URL` accordingly.Need to match your daemon.

For AltCoins,edit your coin class in `env/coins.py`.`env/coins.py` will be append to [electrumx/lib/coins.py](https://github.com/kyuupichan/electrumx/blob/master/lib/coins.py)

Leave others defaults

### Step 2. Build & Run
```shell
docker build -t electrumx .

mkdir /work/electrumx
mkdir /work/electrumx/db
mkdir /work/electrumx/env
mkdir /work/electrumx/log
cp -r env/* /work/electrumx/env/
chown -R 1000:1000 /work/electrumx/*

docker run -it -v /work/electrumx/db:/db -v /work/electrumx/env:/env -v /work/electrumx/log:/log --name electrumx -p 8009:8009 --restart always -d electrumx

docker exec -it electrumx bash
```

## THANKS

### Warmly welcome all kinds of suggestions

Thanks for suggestions from:

[kyuupichan](https://github.com/kyuupichan/electrumx)

[qinshulei](https://github.com/qinshulei)

