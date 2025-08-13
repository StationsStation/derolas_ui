# Build stage
FROM node:22-alpine AS build
WORKDIR /app

# Copy only what's needed to install and build
COPY package.json yarn.lock ./
COPY svelte.config.js vite.config.js postcss.config.js tailwind.config.ts tsconfig.json ./
COPY src ./src
COPY static ./static

RUN yarn install --frozen-lockfile
RUN yarn build

# Serve stage
FROM nginxinc/nginx-unprivileged:1.29.0-alpine-perl
COPY --from=build /app/build /usr/share/nginx/html 
# Or /app/dist if that's your build output

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
