##### app-stream

###### Docker: Build Rails Application
```shell
docker build . -f .docker/Dockerfile --build-arg puma_port="3000" --build-arg env_name="development" -t app-stream --no-cache
```
