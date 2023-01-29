FROM node:16.14.2-bullseye-slim as builder
WORKDIR /test
COPY package.json package.json
RUN yarn install
COPY . .
RUN npm run build

FROM node:16.14.2-bullseye-slim
RUN mkdir -p /app/build
WORKDIR /app
COPY --from=builder /test/build build
RUN apt update && apt install -y jq
RUN npm -g install serve
CMD serve -l tcp://0.0.0.0:5000 -s build