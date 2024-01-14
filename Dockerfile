FROM node:latest AS build
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY ./ .
RUN npm install
RUN npm run build

FROM node:alpine3.18
WORKDIR /root/
COPY --from=build /usr/src/app/dist/main.js .
EXPOSE 3000 
CMD ["node", "main.js"]