# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package.json /app/
RUN npm install --save core-js@^3
RUN npm install
COPY . /app/
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

