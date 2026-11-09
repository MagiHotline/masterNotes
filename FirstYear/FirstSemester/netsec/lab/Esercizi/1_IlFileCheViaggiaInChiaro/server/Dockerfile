FROM alpine:latest

RUN apk update && apk add netcat-openbsd

EXPOSE 1234

RUN mkdir /server
COPY nc_server.sh /server/nc_server.sh

# RUN nc -l 4444 > server/received.txt

#make the container run forever
CMD ["tail", "-f", "/dev/null"]
# or directly run the script
#CMD ["/server/nc_server.sh"]
