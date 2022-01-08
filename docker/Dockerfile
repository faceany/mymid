
FROM ubuntu:20.04

# Needed for string substitution
SHELL ["/bin/bash", "-c"]
# apt source and pip source
RUN rm -rf /etc/apt/sources.list*
COPY sources.list.20.04 /etc/apt/sources.list
RUN mkdir -p /root/.pip
COPY pip.conf /root/.pip/pip.conf
COPY pydistutils.cfg /root/.pydistutils.cfg
RUN mkdir -p /root/mymid
COPY start_mymid.sh /root/mymid

ARG _PY_SUFFIX=3
ARG PYTHON=python${_PY_SUFFIX}
ARG PIP=pip${_PY_SUFFIX}

# See http://bugs.python.org/issue19846
ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y \
    ${PYTHON} \
    ${PYTHON}-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN ${PIP} --no-cache-dir install --upgrade \
    pip \
    setuptools

# Some TF tools expect a "python" binary
RUN ln -s $(which ${PYTHON}) /usr/local/bin/python

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

# Other dependencies
RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    vim \
    unzip \
    zip \
    net-tools \
    iputils-ping \
    telnet \
    iptables \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ENV PATH "${PATH}:/root/.local/bin"
RUN which pip
RUN which pip3
ENV LANG C.UTF-8
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

RUN mkdir /usr/jdk64
RUN pip install ansible
ENTRYPOINT ["bash", "/tiwisdom-trainai/start.sh"]
