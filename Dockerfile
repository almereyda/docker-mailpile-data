FROM busybox:latest
MAINTAINER Jon Richter <post@jonrichter.de>
RUN ["mkdir", "/.mailpile"]
VOLUME ["/.mailpile"]
