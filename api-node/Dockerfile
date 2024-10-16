FROM node:22.9.0-alpine3.19 as base

WORKDIR /app

COPY package*.json .

FROM base as development

RUN --mount=type=cache,target=/app/.npm \
  npm config set cache /app/.npm && npm install

COPY . .

EXPOSE 3000

CMD ["npm", "run", "dev"]

FROM base as production

ENV NODE_ENV=production

RUN --mount=type=cache,target=/app/.npm \
  npm config set cache /app/.npm && npm ci --only=production

COPY . .

USER node

COPY --chown=node:node ./src .

EXPOSE 3000

CMD ["node", "index.js"]