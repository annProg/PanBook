FROM alpine:3.10
RUN apk add --no-cache rsync
COPY pub.sh /bin
RUN chmod +x /bin/pub.sh
ENTRYPOINT ["/bin/pub.sh"]