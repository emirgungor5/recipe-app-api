FROM python:3.9-alpine3.13
LABEL maintainer="emirgungor"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app ./app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [$DEV="true"]; \
      then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user
# run yapmamıızn sebebi imagelarımızı daha stabil ve küçük boyutta çalıştırmak için

ENV PATH="/py/bin:$PATH"

USER django-user

# Bunu kullanmamızın sebebi alpine linux tabanlı bi yazılım ve linux docker da daha verimli çalıştığı için buu kullanıyoruz.