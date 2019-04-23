FROM python:3.6-alpine as base

FROM base as builder

RUN mkdir /install
WORKDIR /install

COPY requirements/test.txt /install/requirements.txt

RUN apk add --update \
        g++ \
        python3-dev \
        libxml2 \
        libxml2-dev &&\
    apk add libxslt-dev
RUN pip install --install-option="--prefix=/install" -r /install/requirements.txt

FROM base

ENV INSTALL_PATH /sunsetter
RUN mkdir ${INSTALL_PATH}
WORKDIR ${INSTALL_PATH}

COPY --from=builder /install /usr/local

COPY . .
