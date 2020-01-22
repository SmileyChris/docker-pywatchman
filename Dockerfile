ARG PYTHON_VERSION
FROM python:3.7 as watchman

# The "folly" component currently fails if "fmt" is not explicitly installed first.
RUN apt-get update && apt-get install -y sudo cmake
WORKDIR /fmt
RUN git clone --depth 1 https://github.com/fmtlib/fmt.git .
RUN cmake .
RUN make -j$(nproc) && sudo make install

WORKDIR /watchman
RUN git clone --depth 1 https://github.com/facebook/watchman.git .
RUN ./autogen.sh
RUN make -j$(nproc) && mkdir /dist && make install DESTDIR=/dist
WORKDIR /dist

FROM python:$PYTHON_VERSION
ENV PIP_NO_CACHE_DIR=1

COPY --from=watchman /dist /
RUN apt-get update \
    && apt-get install -y  \
    gcc \
    libdouble-conversion1 \
    libgoogle-glog0v5 \
    libsnappy1v5 \
    libboost-filesystem1.67.0 \
    libboost-program-options1.67.0 \
    libboost-regex1.67.0 \
    libevent-2.1-6 \
    libboost-context1.67.0 \
    libboost-thread1.67.0 \
    libboost-chrono1.67.0 \
    libboost-date-time1.67.0 \
    && pip install pywatchman \
    && apt-get purge -y gcc \
    && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /usr/local/var/run/watchman/ && \
    chmod 2777 /usr/local/var/run/watchman/
