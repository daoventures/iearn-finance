FROM node:10 as build

WORKDIR /iearn-finance
COPY . /iearn-finance

RUN npm install
RUN npm run build


FROM nginx:alpine

ADD ./certbot/conf /etc/letsencrypt
ADD ./certbot/www /var/www/certbot
COPY --from=build /iearn-finance/build /usr/share/nginx/html

RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/default.conf /etc/nginx/conf.d

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
