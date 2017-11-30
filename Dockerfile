FROM node:8.9.1

# Create a new "app" user
RUN useradd --user-group --create-home --shell /bin/false app

# Hack to Upgrade NPM 
RUN npm install npm@latest
RUN rm -rf /usr/local/lib/node_modules/npm
RUN mv node_modules/npm /usr/local/lib/node_modules/npm

# Set our new home
ENV HOME=/home/app

# Copy the React app into the container
COPY src public package.json $HOME/hello/
RUN chown -R app:app $HOME/*

# Build the application
USER app
WORKDIR $HOME/hello
RUN npm install

# Copy extra configuration
USER root
COPY . $HOME/hello
RUN chown -R app:app $HOME/*
USER app

# Run the application
CMD ["npm", "start"]

