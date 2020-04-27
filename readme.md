# Docker in motion notes

## Instructions
* The instructinos in the *Dockerfile* are read in order, 
* The instructions are save in cache and in the next build it doesn't will be executed.
* If some instruction is changed from the last build, this instructions and the next build be executed again. 

## Pull a docker image
* The command is `docker pull <REPOSITORY_NAME>/<IMAGE_NAME>:<TAG_SEMVER_NUMBER>`
* The *REPOSITORY_NAME* and *TAG_SEMVER_NAME* are optional, if this last is present, we can pull an image different than the last version.

## Useful flags
* -q => with the quiet flag only the images or containers hash will be returned
* -a => with the all flag all the images or containers will be returned
* -h => with the help flag you will get info about any command

## Images
* Are the basis of the Containers
* To manage the images the command used is `docker images`
* To delete an image use `docker rmi <IMAGE_HASH>`
* To delete images without any dependent container => `docker rmi $(docker images -a -q)`
  * $() is a bash variable
  * `docker images -a -q` will return all images hashes
* If we need delete all images, first we need to delete all the containers to ensure that there is no containers dependent in some images


## Containers
* about what is a container [here is an explanation](https://www.docker.com/resources/what-container)
* To get the running container use `docker ps` with the `-a` flag, all the containers will be listed
* To delete a container use `docker rm <IMAGE_HASH>`
* To delete all containers run `docker rm $(docker ps -a -q)`

## COPY and ADD
* Is used to copy data to the docker folder
* Is better to use COPY instead of ADD, unless ADD utilities are necessary
* Only the files inside the working directory can be manipulate with COPY and ADD

## Dockefile ENV
* Are environment variables and here can't be passed sensitive information because it isn't a secure place to store it.

## Dockerfile ARG
* Can be used to change some ARG variable inside the dockerfile, in the current docker file it can be changed the version of Ky.
* In the docker build command is added the --build-arg flag, and the variable is changed adding the same name of the ARG variable inside the Dockerfile and the equals sign to change its value, the last command is the *.* the command will be like:

`docker build --build-arg KY_VERSION=0.19.0 .`

## Tag an image
* The REPOSITORY_NAME is optional
* This process can't be done in the Dockerfile
* To tag a existing build image use `docket tag <IMAGE_HASH> <REPOSITORY_NAME>/<IMAGE_NAME>:<TAG_SEMVER_NUMBER>`
* To tag a image in the build process `docker build -t  <REPOSITORY_NAME>/<IMAGE_NAME>:<TAG_SEMVER_NUMBER>`.

## Push an image to docker hub
* `docker push <REPOSITORY_NAME>/<IMAGE_NAME>:<TAG_SEMVER_NUMBER>` 
* Is important first tag the image with the repository name.
* Only will be pushed the images that doesn't exist, for example, in the Dockerfile existent in this  repository, the layers from ubuntu doesn't will be upload and in the console the message that indicates this is *Mounted from*, this is an example:
```bash
The push refers to repository [docker.io/oscarvelandia235/webserver]
43efa168d6c4: Pushed 
2de177c0e60a: Pushed 
f686fe675ded: Pushed 
8891751e0a17: Mounted from library/ubuntu 
2a19bd70fcd4: Mounted from library/ubuntu 
9e53fd489559: Mounted from library/ubuntu 
7789f1a3d4e9: Mounted from library/ubuntu 
0.0.1: digest: sha256:5e8ea3eb3f2f1345bc4626fdfdd47fbf20d3636effb75d512f931e76975a0a56 size: 1779
```
* To update the image with a new tag, is necessary update the Dockerfile and change the `<TAG_SEMVER_NUMBER>`, after that, the command is the same `docker push` with the new tag number

## Interesting links
* [Docker cheat sheet](https://www.docker.com/sites/default/files/d8/2019-09/docker-cheat-sheet.pdf)
* [Docker glossary](https://docs.docker.com/glossary/)
* [Docker best practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)