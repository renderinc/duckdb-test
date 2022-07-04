FROM node:latest

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TERM=xterm-256color \
    DEBIAN_FRONTEND=noninteractive

WORKDIR /home/render

# get the data file first
RUN wget --quiet https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2019-01.parquet

RUN apt-get -qq update \
  && apt-get -qq install -y --no-install-recommends \
    ca-certificates \
    wget \
    curl \
    gnupg2 \
    lsb-release \
  > /dev/null \
  && apt-get -qq clean \
  && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
  && :

# we'll use hyperfine for performance tests
RUN wget https://github.com/sharkdp/hyperfine/releases/download/v1.14.0/hyperfine_1.14.0_amd64.deb && \
    dpkg -i hyperfine_1.14.0_amd64.deb && \
    rm hyperfine_1.14.0_amd64.deb

RUN wget -q https://github.com/duckdb/duckdb/releases/download/v0.4.0/duckdb_cli-linux-amd64.zip && \
    unzip duckdb_cli-linux-amd64.zip && \
    rm -rf duckdb_cli-linux-amd64.zip

ENV PORT="${PORT:-10000}"

COPY . .

CMD npx --yes -q node-static -a 0.0.0.0 -p $PORT
