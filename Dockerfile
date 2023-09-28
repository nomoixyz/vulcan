FROM ubuntu:mantic

RUN apt update &&\
    apt install -y\
    git\
    curl

WORKDIR /home/ubuntu/vulcan

COPY .gitmodules foundry.toml remappings.txt ./
COPY src/ ./src
COPY test/ ./test
COPY lib/ ./lib

RUN chown ubuntu:ubuntu -R .

USER ubuntu

ENV PATH "${PATH}:/home/ubuntu/.local/bin:/home/ubuntu/.foundry/bin:/home/ubuntu/.huff/bin"

RUN git init && git add .
RUN curl -L https://foundry.paradigm.xyz | bash
RUN curl -L get.huff.sh | bash
RUN foundryup
RUN huffup
RUN forge install --no-commit
RUN mkdir -p /home/ubuntu/.local/bin && curl -o /home/ubuntu/.local/bin/fe -L https://github.com/ethereum/fe/releases/download/v0.24.0/fe_amd64
RUN chmod +x /home/ubuntu/.local/bin/fe

ENTRYPOINT [ "forge", "test" ]

