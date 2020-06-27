FROM codercom/code-server:3.4.1
USER root
COPY sources.list /etc/apt/sources.list
RUN apt-get update --fix-missing\
  && apt-get install -y \
  curl \
  wget \
  ruby \
  python \
  openjdk-11-jdk \
  python3 \
  nodejs \
  && rm -rf /var/lib/apt/lists/*

RUN curl -o go1.14.4.linux-amd64.tar.gz  https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf go1.14.4.linux-amd64.tar.gz && \
  rm -rf go1.14.4.linux-amd64.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"

RUN go env -w GO111MODULE=on \
  & go env -w GOPROXY=https://goproxy.io,direct

USER coder

RUN for i in ms-ceintl.vscode-language-pack-zh-hans \
  auchenberg.vscode-browser-preview \
  formulahendry.code-runner \
  ms-vscode.go \
  searking.preview-vscode \
  ms-vscode-remote.remote-ssh \
  formulahendry.terminal \
  bajdzis.vscode-database \
  hookyqr.beautify \
  donjayamanne.githistory \
  eamodio.gitlens \
  ms-python.python \
  vscjava.vscode-java-pack \
  waderyan.nodejs-extension-pack \
  dbaeumer.vscode-eslint \
  visualstudioexptteam.vscodeintellicode \
  vscoss.vscode-ansible \
  ms-vscode.cpptools \
  rebornix.ruby ;do /usr/bin/code-server --install-extension "$i"; done

COPY languagepacks.json /tmp


COPY entrypoint.sh /usr/local/bin/

RUN  cp /tmp/languagepacks.json /home/coder/.local/share/code-server/languagepacks.json \
  & chmod +x /usr/local/bin/entrypoint.sh \
  & chown coder.coder /home/coder/.local/share/code-server/languagepacks.json \
  & curl https://marketplace.visualstudio.com/_apis/public/gallery/publishers/auchenberg/vsextensions/vscode-browser-preview/0.6.7/vspackage  -o browser-preview-0.6.7.vsix\
  & /usr/bin/code-server --install-extension browser-preview-0.6.7.vsix \
  & rm -rf *.vsix

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
