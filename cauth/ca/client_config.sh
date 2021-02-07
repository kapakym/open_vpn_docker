#!/bin/sh

client_base_conf="client_base_conf.ovpn"
ca_file="./pki/ca.crt"
tls_aut_key="./ta.key"
client_crt_ext=".crt"
client_key_ext=".key"
client_conf_ext=".ovpn"

client=$1
if [ "$client" = "" ]; then
  echo "missing client name" 1>&2
  exit
fi

client_crt="./pki/issued/"${client}${client_crt_ext}
client_key="./pki/private/"${client}${client_key_ext}

echo ${client_crt}
echo ${client_key}

if [ ! -f $client_crt ]; then
  echo "no such file: $client_crt" 1>&2
  exit
fi

if [ ! -f $client_key ]; then
  echo "no such file: $client_key" 1>&2
  exit
fi

config_dir="./client_config/$client"
mkdir $config_dir

congif=${client}${client_conf_ext}.tmp
congif_file=${config_dir}"/"${client}${client_conf_ext}

cp $ca_file $config_dir
cp $tls_aut_key $config_dir
cp $client_crt $config_dir
cp $client_key $config_dir


cat $client_base_conf > $congif
echo "" >> $congif

echo "<ca>" >> $congif
cat $ca_file | \
  grep -A 100 "BEGIN CERTIFICATE" | \
  grep -B 100 "END CERTIFICATE" >> $congif
echo "</ca>" >> $congif

echo "<cert>" >> $congif
cat $client_crt | \
  grep -A 100 "BEGIN CERTIFICATE" | \
  grep -B 100 "END CERTIFICATE" >> $congif
echo "</cert>" >> $congif

echo "<key>" >> $congif
cat $client_key | \
  grep -A 100 "BEGIN PRIVATE KEY" | \
  grep -B 100 "END PRIVATE KEY" >> $congif
echo "</key>" >> $congif


if [ -f $tls_aut_key ]; then
echo "key-direction 1" >> $congif
echo "<tls-auth>" >> $congif
cat $tls_aut_key | \
  grep -A 100 "BEGIN OpenVPN Static key V1" | \
  grep -B 100 "END OpenVPN Static key V1" >> $congif
echo "</tls-auth>" >> $congif
fi

echo $congif_file

tr -d '\r' < $congif > $congif_file
rm $congif
exit
