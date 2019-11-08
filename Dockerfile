FROM alpine:3.10
MAINTAINER Patrick Kuijvenhoven <patrick.kuijvenhoven@gmail.com>

ARG VERSION
RUN apk add --no-cache python3 git curl patch \
    && mkdir -p /usr/local/src/ \
    && cd /usr/local/src \
    && git clone https://github.com/mmlb/yamlfmt.git \
    && cd yamlfmt \
    && git checkout ${VERSION} \
    && curl -s -L https://github.com/mmlb/yamlfmt/pull/14.patch | patch -p1 \
    && apk add --no-cache git curl patch \
    && cd /usr/local/src/yamlfmt \
    && pip3 install . \
    && rm -rf /usr/local/src/yamlfmt \
    && find /usr/lib/ \( -name '__pycache__' -o -name '*.pyc' \) -print0 | xargs -0 -n1 rm -rf 

WORKDIR /
ENTRYPOINT [ "/usr/bin/yamlfmt" ]
CMD [ "-h" ]
