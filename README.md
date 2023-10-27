##### app-stream

###### Docker: Build Rails Application
```shell
docker build . -f .gitlab/app/Dockerfile --build-arg puma_port="3000" --build-arg env_name="development" -t backend --no-cache
```
