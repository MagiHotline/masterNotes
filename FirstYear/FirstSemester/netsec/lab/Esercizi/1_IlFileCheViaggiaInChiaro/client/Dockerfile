FROM alpine:latest
RUN apk add --no-cache bash netcat-openbsd

RUN mkdir /client
COPY nc_client.sh /client/nc_client.sh

# RUN printf 'CCIT{ILMIOTESORO}\n' > client/secret.txt

#make the container run forever
CMD ["tail", "-f", "/dev/null"]
# or directly run the script
#CMD ["/client/nc_client.sh"]
