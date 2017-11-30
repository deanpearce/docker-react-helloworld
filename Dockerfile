FROM node:8.9.1

RUN useradd --user-group --create-home --shell /bin/false app

RUN npm install npm@latest
RUN rm -rf /usr/local/lib/node_modules/npm
RUN mv node_modules/npm /usr/local/lib/node_modules/npm

# RUN apk add --update nodejs nodejs-npm \&& 
#  npm install npm@latest -g
#  npm install semver@latest -g

ENV HOME=/home/app

COPY src public package.json $HOME/hello/
RUN chown -R app:app $HOME/*

USER app
WORKDIR $HOME/hello
RUN npm install

USER root
COPY . $HOME/hello
RUN chown -R app:app $HOME/*
USER app

CMD ["npm", "start"]

