FROM python:3.11.6-bullseye

WORKDIR /app

RUN apt update
RUN apt install -y git make build-essential curl

RUN git clone https://github.com/imartinez/privateGPT .

RUN pip3 install poetry
RUN poetry install --with ui

WORKDIR /app/sqlite/
RUN wget -c https://www.sqlite.org/2023/sqlite-autoconf-3440000.tar.gz
RUN tar xvfz sqlite-autoconf-3440000.tar.gz && rm sqlite-autoconf-3440000.tar.gz
WORKDIR /app/sqlite/sqlite-autoconf-3440000
RUN ls -la && ./configure
RUN make
RUN make install

RUN pip3 install llama-cpp-python

WORKDIR /app
COPY run.sh .
EXPOSE 8001

RUN poetry install --with local

ENV LD_LIBRARY_PATH="/usr/local/lib"

CMD ["/bin/bash", "run.sh"]


