# AirSane for OpenWRT
## Usage
### Download OpenWRT SDK
The easiest way is to use Docker image\
https://hub.docker.com/r/openwrtorg/sdk
### Prepare
Add repo
```
echo "src-git airsaned https://github.com/tbaela/AirSane-openwrt.git" >> feeds.conf.default
```

Update feeds
```
./scripts/feeds update -a && ./scripts/feeds install -a
```
### Compile
```
make package/airsaned/compile V=s -j <CORES_NUM>
```

### Install
1) Copy package to temp folder on your router\
```scp bin/packages/<ARCH>/airsaned/airsaned-<VERSION>.ipk root@<YOUR_ROUTER_IP>:/tmp```
2) Login via ssh\
```ssh root@<YOUR_ROUTER_IP>```
3) Install package via opkg\
```opkg install /tmp/airsaned-<VERSION>.ipk```

### Configure
You can edit configuration here\
```/etc/config/airsaned```

### Use
Run\
```/etc/init.d/airsaned start```

Run at startup\
```/etc/init.d/airsaned enable```
