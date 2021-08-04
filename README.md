# CONTAINER MANAGEMENT USING PODMAN


## Create FastAPI Application
First, create simple application with fastapi.

```python
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    return {"pesan": "Halo Dunia"}

```

## Create Containerfile for fastapi
Create Containerfile.

```
FROM python:3.8.5-alpine

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
```

## Build and Deploy container using Podman
When Containerfile already created, now build images of fastapi application.

```bash
$ podman build -t fastapi .
```

Check if images successfully created.
```bash
$ podman images
REPOSITORY                TAG           IMAGE ID      CREATED         SIZE
localhost/fastapi         latest        b6e2a7315140  17 seconds ago  520 MB
docker.io/library/python  3.8.5-alpine  0f03316d4a27  10 months ago   44.7 MB
``` 

And then deploy the image to container.
```bash
$ podman run -dt -p 8000:8000/tcp localhost/fastapi
```

Finally check if container already run.
```bash
$ podman ps -a
```

## Testing application in container
Testing url of container using curl.
```bash
$ curl localhost:8000
{"pesan": "Halo Dunia"}
```

---

### Reference
[Fastapi Tutorial](https://fastapi.tiangolo.com/tutorial/first-steps/)
[Podman Tutorial](https://podman.io/getting-started/)
