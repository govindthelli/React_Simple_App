FROM node:18 AS build

WORKDIR /app

COPY package*.json ./app

RUN npm install

COPY . .

RUN npm run build

FROM nginx:latest

RUN rm -f /usr/share/nginx/html/

COPY --from=build ./app/build /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
