# PODS

### Create New Pod
```bash
$ podman pod create -n nurja --share cgroup,ipc,uts
```

### Attach Images to This Pod
```bash
$ podman run -dt --pod nurja --rm --name api -p 8000:8000 localhost/fastapi
```

### Check if New Pod created and exists
```bash
$ podman ps -a --pod
```

### Test the container in New Pod
```bash
$ curl localhost:8000
```

### Attach MongoDB Image to This Pod (nurja)
```bash
$ podman run -dt --pod nurja --rm --name dbs -v ~/.data:/data/db -e MONGODB_DATABASE=basisdata -p 27017:27017 --name mongodb docker.io/library/mongo
```

### Testing the MongoDB Pod
```python
from pymongo import MongoClient
client = MongoClient()
client.admin.command('ping')
```

### Delete pods and its container
```bash
$ podman pod rm nurja
```