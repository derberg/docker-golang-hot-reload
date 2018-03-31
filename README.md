![Docker Pulls](https://img.shields.io/docker/pulls/derberg/docker-golang-hot-reload.svg)

# Docker Golang Hot-Reload

This repo contains `Dockerfile` for image containing Go v1.9.2 and [Fresh](https://github.com/pilu/fresh) reloader.

## Usage

Below example assumes you run the image in your project's location
```
#my-project is your project's location
PROJECT=/go/src/{my-project}

#below container run does the following
#rm - makes sure that once you stop the container it is immediately removed
#v - mounts your current directory into a container under proper location needed for Go
#w - sets working directory inside container to the one you mounted in your project. This is necessary, Go magic
#p - exposes port 3000 from inside to 3000 outside
docker run --rm \
    -v $(PWD):$PROJECT \
    -w $PROJECT \
    -p 3000:3000 \
    derberg/docker-golang-hot-reload:1.0
```

## Vendor directory case

Fresh is awesome, but every tool has some limits. For Fresh it is `vendor` directory with your dependencies. You need to exclude it by putting below config file in the root of your project:

```
root:              .
tmp_path:          ./tmp
build_name:        runner-build
build_log:         runner-build-errors.log
valid_ext:         .go 
no_rebuild_ext:    .tpl, .tmpl, .html
ignored:           vendor
build_delay:       600
colors:            1   
log_color_main:    cyan
log_color_build:   yellow
log_color_runner:  green
log_color_watcher: magenta
log_color_app:
```

## Image publishing

```
docker login
docker build -t docker-golang-hot-reload .
docker tag docker-golang-hot-reload derberg/docker-golang-hot-reload:1.0
docker push derberg/docker-golang-hot-reload:1.0
```
