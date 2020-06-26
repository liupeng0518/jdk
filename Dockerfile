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
USER coder

RUN /usr/bin/code-server --install-extension \
&& /usr/bin/code-server --install-extension ms-ceintl.vscode-language-pack-zh-hans \
&& /usr/bin/code-server --install-extension formulahendry.code-runner \
&& /usr/bin/code-server --install-extension golang.go \
&& /usr/bin/code-server --install-extension searking.preview-vscode \
&& /usr/bin/code-server --install-extension ms-vscode-remote.remote-ssh \
&& /usr/bin/code-server --install-extension formulahendry.terminal \
&& /usr/bin/code-server --install-extension bajdzis.vscode-database \
&& /usr/bin/code-server --install-extension hookyqr.beautify \
&& /usr/bin/code-server --install-extension donjayamanne.githistory \
&& /usr/bin/code-server --install-extension eamodio.gitlens \
&& /usr/bin/code-server --install-extension ms-python.python \
&& /usr/bin/code-server --install-extension vscjava.vscode-java-pack \
&& /usr/bin/code-server --install-extension swellaby.node-pack \
&& /usr/bin/code-server --install-extension rebornix.ruby \
&& /usr/bin/code-server --install-extension ms-azuretools.vscode-docker \
&& /usr/bin/code-server --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
