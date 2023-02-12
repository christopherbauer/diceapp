FROM node:18-alpine
ENV CI=true

RUN apk update
RUN apk add nano openssl

WORKDIR /app/api
COPY . .
RUN npm install --silent

CMD ["npm", "run", "dev"]
# ENTRYPOINT ["tail", "-f", "/dev/null"]