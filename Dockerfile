FROM codercom/code-server:3.4.1
USER root
RUN apt-get update \
  && apt-get install -y \
  ruby \
  python \
  default-jdk \
  python3 \
  nodejs \
  && rm -rf /var/lib/apt/lists/*

RUN curl -o go1.14.4.linux-amd64.tar.gz  https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf go1.14.4.linux-amd64.tar.gz && \
  rm -rf go1.14.4.linux-amd64.tar.gz

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

USER coder

RUN for i in ms-ceintl.vscode-language-pack-zh-hans \
  formulahendry.code-runner \
  golang.go \
  searking.preview-vscode \
  ms-vscode-remote.remote-ssh \
  formulahendry.terminal \
  bajdzis.vscode-database \
  hookyqr.beautify \
  donjayamanne.githistory \
  eamodio.gitlens \
  ms-python.python \
  vscjava.vscode-java-pack \
  swellaby.node-pack \
  rebornix.ruby \
  ms-azuretools.vscode-docker \
  ms-kubernetes-tools.vscode-kubernetes-tools;do /usr/bin/code-server --install-extension "$i"; done

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
