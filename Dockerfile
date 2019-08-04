FROM alpine:3.10

RUN apk add --no-cache texlive-full curl bash
RUN cd /tmp/ && curl -s -L https://github.com/jgm/pandoc/releases/download/2.7.3/pandoc-2.7.3-linux.tar.gz -o pandoc.tar.gz && tar -zxvf pandoc.tar.gz  && mv pandoc-2.7.3/bin/* /usr/local/bin && rm -fr /tmp/*
RUN cd /tmp/ && curl -s -L https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.4.1/linux-pandoc_2_7_2.tar.gz -o crossref.tar.gz && tar -zxvf crossref.tar.gz && mv pandoc-crossref /usr/local/bin && rm -fr /tmp/*

COPY tools/docker/texlive-fontconfig.conf /etc/fonts/conf.d/09-texlive-fonts.conf

RUN [ ! -d /usr/share/fonts ] && mkdir /usr/share/fonts
RUN curl -s -L https://github.com/adobe-fonts/source-han-serif/releases/download/1.001R/SourceHanSerif.ttc -o /usr/share/fonts/SourceHanSerif.ttc
RUN curl -s -L https://github.com/adobe-fonts/source-han-sans/releases/download/2.001R/SourceHanSans.ttc -o /usr/share/fonts/SourceHanSans.ttc
RUN fc-cache -sfv
RUN apk add --no-cache make
ENV PATH /PanBook:$PATH
RUN mkdir /data

# plot 相关组件
RUN curl -s -L https://github.com/akavel/ditaa/releases/download/g1.0.0/ditaa-linux-amd64 -o /usr/local/bin/ditaa && chmod +x /usr/local/bin/ditaa
RUN apk add --no-cache graphviz librsvg
RUN curl -s -L https://github.com/pandoc-ebook/goseq/releases/download/v1.0/goseq-linux-amd64 -o /usr/local/bin/goseq && chmod +x /usr/local/bin/goseq
RUN curl -s -L https://github.com/pandoc-ebook/asciitosvg/releases/download/v1.0/a2s-linux-amd64 -o /usr/local/bin/a2s && chmod +x /usr/local/bin/a2s
RUN apk add --no-cache gnuplot
# dvisvgm need by asymptote
RUN apk add --no-cache --virtual .build-deps \	
	build-base autoconf automake libtool texlive-dev freetype-dev brotli-dev woff2-dev && \
	cd /root && \
	wget https://github.com/mgieseki/dvisvgm/archive/2.7.4.tar.gz && \
	tar zxvf 2.7.4.tar.gz && \
	cd dvisvgm-2.7.4 && \
	./autogen.sh && ./configure && make && make install && \
	cd ../ && rm -fr dvisvgm* *.tar.gz && \
	apk del .build-deps
# need by asymptote and dvisvgm(libwoff2dec)
RUN apk add --no-cache ghostscript gsl freeglut gc fftw libwoff2dec
# asymptote
RUN apk add --no-cache --virtual .build-deps \
	build-base bison flex zlib-dev autoconf \
	gsl-dev freeglut-dev gc-dev fftw-dev && \
	cd /root && \
	wget https://github.com/vectorgraphics/asymptote/archive/2.49.tar.gz && \
	tar zxvf 2.49.tar.gz && \
	cd asymptote-2.49 && \
	./autogen.sh && \
	./configure && \
	make asy && \
	make asy-keywords.el && \
	make install-asy;true && \
	cd ../ && rm -fr asymptote* *.tar.gz && \
	apk del .build-deps
# abcm2ps (poppler-utils 提供 pdftocairo)
RUN apk add --no-cache poppler-utils
RUN curl -s -L "https://sourceforge.net/projects/abcplus/files/abcm2ps/abcm2ps-8.14.5" -o /usr/bin/abcm2ps && chmod +x /usr/bin/abcm2ps

ENV TIMEZONE Asia/Shanghai
RUN apk add --no-cache tzdata git
RUN cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
RUN echo "${TIMEZONE}" > /etc/timezone

COPY . /PanBook/
RUN chmod +x /PanBook/panbook
WORKDIR /data

ENTRYPOINT ["panbook"]