image_name=$1
container_name=$2

if [ "$image_name" = "" ]; then
  echo "missing image name" 1>&2
  exit
fi

if [ "$container_name" = "" ]; then
  echo "missing container name" 1>&2
  exit
fi

docker run -ti -p 2222:22 --name $container_name $image_name bash /home/causer/ca/run.sh
