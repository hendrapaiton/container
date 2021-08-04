FROM docker.io/library/python:3.8.5-alpine

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /app/requirements.txt

RUN set -eux \
    && apk add --no-cache --virtual .build-deps build-base libressl-dev libffi-dev gcc musl-dev python3-dev \
    && pip install --upgrade pip setuptools wheel \
    && pip install -r /app/requirements.txt \
    && rm -rf /root/.cache/pip

COPY . /app/

CMD ["uvicorn", "server.app:app", "--host", "0.0.0.0", "--port", "8000"]