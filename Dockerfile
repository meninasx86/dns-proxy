FROM alpine

RUN apk update && \
    apk upgrade && \
    apk add --update bash iptables && \
    rm -rf /var/cache/apk/*

RUN mkdir /dns-proxy
WORKDIR /dns-proxy
ADD config ./
ADD clean ./

CMD ./config
