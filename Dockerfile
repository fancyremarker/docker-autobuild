FROM progrium/buildstep
MAINTAINER Frank Macreery <frank@macreery.com>

# See https://github.com/docker/docker/issues/6345#issuecomment-49245365
RUN ln -s -f /bin/true /usr/bin/chfn

ADD files/exec-wrapper /exec-wrapper
ADD files/builder-wrapper /builder-wrapper

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN apt-get install wget ca-certificates
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get -y update && apt-get -y upgrade && \
    apt-get -y install postgresql-9.4 postgresql-client-9.4 postgresql-contrib-9.4

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
