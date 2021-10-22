FROM crystallang/crystal:1.2.1-alpine as base

RUN apk add --no-cache collectd
