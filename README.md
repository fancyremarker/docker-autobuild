# ![](https://gravatar.com/avatar/11d3bc4c3163e3d238d558d5c9d98efe?s=64) aptible/autobuild

[![Docker Repository on Quay.io](https://quay.io/repository/aptible/autobuild/status)](https://quay.io/repository/aptible/autobuild)

Autobuilding Docker base image, providing a thin layer of automation on progrium/buildstep.

## Installation and Usage

    docker pull quay.io/aptible/autobuild
    docker run -i -t quay.io/aptible/autobuild

## Available Tags

* `latest`: Default autobuilder (built progrium/buildstep, which is based on Ubuntu 14.04)

## Usage

To autobuild your app using this image, add the following Dockerfile to your repository:

```
# Dockerfile
FROM quay.io/aptible/autobuild
```

Then run `docker build .`

## Deployment

To push the Docker image to Quay, run the following command:

    make release

## Copyright and License

MIT License, see [LICENSE](LICENSE.md) for details.

Copyright (c) 2015 [Aptible](https://www.aptible.com), [Frank Macreery](https://github.com/fancyremarker), and contributors.
