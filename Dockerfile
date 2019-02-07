# tag the phase, everything below will refer to "builder" phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# new phase
FROM nginx
# this is for elastic beanstalk for port forwarding
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
