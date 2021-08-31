# Stage 1
FROM node:14.17.5-alpine as builder

WORKDIR /app

COPY . .

RUN yarn install --frozen--lockfile --ignore-scripts

RUN yarn build:prod

# Stage 2
FROM node:14.17.5-alpine as prod

LABEL maintainer="Iric<iricbing@gmail.com>"

WORKDIR /app

# 设置时区
RUN echo "Asia/Shanghai" > /etc/timezone && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 

# 设置NODE最大可用内存
# ENV NODE_OPTIONS=--max-old-space-size=6144

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package.json .
COPY --from=builder /app/yarn.lock .

RUN yarn install --frozen--lockfile --ignore-scripts --prod

EXPOSE 3000

CMD ["node" ,"dist/main.js"]