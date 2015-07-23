FROM progrium/buildstep
MAINTAINER Frank Macreery <frank@macreery.com>

# See https://github.com/docker/docker/issues/6345#issuecomment-49245365
RUN ln -s -f /bin/true /usr/bin/chfn

ADD files/exec-wrapper /exec-wrapper
ADD files/builder-wrapper /builder-wrapper

RUN apt-get update && \
    apt-get -y install postgresql-client-9.3 postgresql-contrib-9.3

ONBUILD ADD . /app
ONBUILD RUN /builder-wrapper

# Set and expose default port
ENV PORT 3000
EXPOSE 3000

# Relax permissions on files/directories used by cron to allow for easier cron setup.
RUN chmod 777 /var/log
RUN chmod 777 /var/run
RUN chmod 0777 /var/spool/cron
RUN chmod 1777 /var/spool/cron/crontabs
RUN chmod go+s /usr/bin/crontab
RUN chmod u+s /usr/sbin/cron

ENTRYPOINT ["/exec-wrapper"]
