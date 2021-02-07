image_name=$1
container_name=$2
container_dir=$3

if [ "$image_name" = "" ]; then
  echo "missing image name" 1>&2
  exit
fi

if [ "$container_name" = "" ]; then
  echo "missing container name" 1>&2
  exit
fi

if [ "$container_dir" = "" ]; then
  echo "missing directory name" 1>&2
  exit
fi

mkdir $container_dir
cp -R ./config_server/* $container_dir/
cp ta.key $container_dir/keys/
docker run --cap-add=NET_ADMIN --device /dev/net/tun --sysctl net.ipv6.conf.all.disable_ipv6=0 -d -p 1194:1194/udp -v $container_dir:/etc/openvpn --name $container_name $image_name openvpn /etc/openvpn/server.conf
docker cp $container_name:/key/ta.key .

