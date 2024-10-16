FROM node:22.9.0-bullseye AS development

WORKDIR /app

COPY package*.json ./

RUN --mount=type=cache,target=/app/.npm \
  npm config set cache /app/.npm && npm install

COPY . .

EXPOSE 5173

CMD ["npm", "run", "dev"]

FROM node:22.9.0-bullseye AS production-build

WORKDIR /app

COPY package*.json ./

RUN --mount=type=cache,target=/app/.npm \
  npm config set cache /app/.npm && npm ci

COPY . .

RUN npm run build

FROM nginxinc/nginx-unprivileged:1.21.3-alpine AS production

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=production-build /app/dist /usr/share/nginx/html

EXPOSE 8080