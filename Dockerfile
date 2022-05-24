# Build Phase
FROM node:16-alpine AS builder
USER node
RUN mkdir -p /home/node/app
WORKDIR /home/node/app
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./
RUN npm run build

# Build Phase
# FROM node:16-alpine AS builder
# WORKDIR /app
# COPY package.json .
# RUN npm install
# COPY . .
# RUN npm run build

# Run Phase
FROM nginx
EXPOSE 80
COPY --from=builder /home/node/app/build /usr/share/nginx/html
# COPY --from=builder /app/build /usr/share/nginx/html
