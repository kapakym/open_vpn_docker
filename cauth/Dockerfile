FROM ubuntu
RUN apt update \ 
	&& apt -y install ssh \
	&& useradd causer -p 12345678 
COPY ./ /home/causer/

