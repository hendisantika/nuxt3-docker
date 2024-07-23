FROM node:20-alpine AS base
LABEL authors="hendisantika"

WORKDIR /app
RUN npm i -g pnpm

FROM base AS dependencies

WORKDIR /app

COPY package.json pnpm-lock.yaml .npmrc ./
RUN pnpm i

FROM base AS build

WORKDIR /app
COPY . .
COPY --from=dependencies /app/node_modules ./node_modules
RUN pnpm build

FROM node:20-alpine AS deploy

WORKDIR /app
COPY --from=build /app/.output/ ./.output/
CMD [ "node", ".output/server/index.mjs" ]

FROM base AS build-ssg

WORKDIR /app
COPY . .
COPY --from=dependencies /app/node_modules ./node_modules
RUN pnpm generate

FROM nginx:1.23.3-alpine AS deploy-ssg

WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=build-ssg /app/.output/public .
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]