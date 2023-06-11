# Stage 1
FROM node:gallium-alpine3.18 as build
WORKDIR /app
COPY package.json .
COPY package-lock.json .
RUN npm install
COPY . .
RUN npm run install-all

# Stage 2
FROM nginx
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
RUN echo ${PWD} && ls -la
COPY --from=build /app/build .
ENTRYPOINT ["nginx", "-g", "daemon off;"]
