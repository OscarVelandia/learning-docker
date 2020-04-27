# a comment
FROM ubuntu
LABEL maintainer "Oscar"
LABEL image_type "Nginx webserver with PHP"
# The ARG value can be changed in the docker build command 
ARG KY_VERSION=@0.19.1 

# Is better add the ENV variables before the RUN instruction
ENV DOC_ROOT /var/www/mysite-dev \
  KY_VERSION ${KY_VERSION}
# With 3 separated RUN, can be a cache error because every RUN instruction generate a layer
# The bellow comands are linux related not docker
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \ 
  nginx \
  neofetch \
  php7.0 \
  # With this command we will remove the app cache to made the image more light
  && rm -rf /var/lib/apt/lists/*

# this instruction copy the data from the first route to the second route, the second route uses the ENV variable write before
COPY code/sites/mysite ${DOC_ROOT}
# The destination path folder will be created automatically if it doesn't exist
ADD https://unpkg.com/ky${KY_VERSION}/index.js ${DOC_ROOT}/js
