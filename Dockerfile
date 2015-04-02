FROM progrium/buildstep
MAINTAINER Frank Macreery <frank@macreery.com>

# See https://github.com/docker/docker/issues/6345#issuecomment-49245365
RUN ln -s -f /bin/true /usr/bin/chfn

ADD files/exec-wrapper /exec-wrapper

ONBUILD ADD . /app
ONBUILD RUN /build/builder

# Set and expose default port
ENV PORT 3000
EXPOSE 3000

ENTRYPOINT ["/exec-wrapper"]
