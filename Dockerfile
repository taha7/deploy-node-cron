FROM node:16-alpine AS builder

WORKDIR /app

# Install dependencies
COPY ./package.json .
RUN yarn install

COPY . .

# Build typescript
RUN yarn global add typescript 
RUN yarn build


FROM node:16-alpine AS final
WORKDIR /app
COPY --from=builder ./app/dist ./dist

COPY package.json .
COPY yarn.lock .
RUN yarn install --production


CMD [ "yarn", "start" ]
