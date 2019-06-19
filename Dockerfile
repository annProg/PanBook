FROM alpine:edge

RUN apk add --no-cache texlive-full wget bash
RUN cd /tmp/ && wget https://github.com/jgm/pandoc/releases/download/2.7.3/pandoc-2.7.3-linux.tar.gz -O pandoc.tar.gz && tar zxvf pandoc.tar.gz && mv pandoc-2.7.3/bin/* /usr/local/bin && rm -fr /tmp/*
RUN cd /tmp/ && wget https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.4.1/linux-pandoc_2_7_2.tar.gz -O pandoc-crossref.tar.gz && tar zxvf pandoc-crossref.tar.gz && mv pandoc-crossref /usr/local/bin && rm -fr /tmp/*

COPY . /PanBook/

RUN export PATH=$PATH:/PanBook
RUN mkdir /data
WORKDIR /data
ENTRYPOINT ["panbook"]