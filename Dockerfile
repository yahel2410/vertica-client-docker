FROM python:2.7-slim-stretch

ARG VERTICA_VERSION

# install pkgs
COPY requirements.txt requirements.txt
RUN apt-get update && \
    apt-get install -y wget python-dev unixodbc unixodbc-dev g++ && \
    pip install -r requirements.txt && \
    apt-get -y autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get purge -y --auto-remove gcc-6 gcc libgcc-6-dev

# install Vertica Client
COPY misc/download_client.sh .
RUN bash ./download_client.sh $VERTICA_VERSION && \
    chown -R root:root /opt && \
    rm -f /opt/vertica/lib/libverticaodbc.so && \
    chmod +x /opt/vertica/bin/* && \
    export LANG="en_US.UTF-8" && \
    export PATH="/opt/vertica/bin:$PATH" && \
    export MANPATH="/opt/vertica/man:$MANPATH"

# set /etc/vertica.ini
COPY etc/vertica.ini /etc/vertica.ini
ENV VERTICAINI='/etc/vertica.ini'

