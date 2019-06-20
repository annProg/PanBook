FROM alpine:edge

RUN apk add --no-cache texlive-full curl bash
RUN cd /tmp/ && curl -s -L https://github.com/jgm/pandoc/releases/download/2.7.3/pandoc-2.7.3-linux.tar.gz -o pandoc.tar.gz && tar -zxvf pandoc.tar.gz  && mv pandoc-2.7.3/bin/* /usr/local/bin && rm -fr /tmp/*
RUN cd /tmp/ && curl -s -L https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.4.1/linux-pandoc_2_7_2.tar.gz -o crossref.tar.gz && tar -zxvf crossref.tar.gz && mv pandoc-crossref /usr/local/bin && rm -fr /tmp/*

COPY tools/docker/texlive-fontconfig.conf /etc/fonts/conf.d/09-texlive-fonts.conf
RUN fc-cache -sfv
RUN apk add --no-cache make
ENV PATH /PanBook:$PATH
RUN mkdir /data

COPY . /PanBook/
RUN chmod +x /PanBook/panbook
WORKDIR /data
ENTRYPOINT ["panbook"]