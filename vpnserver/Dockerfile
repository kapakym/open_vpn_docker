FROM ubuntu
RUN apt update \
    && apt install -y openvpn \
    && mkdir /key \
    && openvpn --genkey --secret /key/ta.key \
    && chmod 666 /key/ta.key \
    && ls -l /key/





