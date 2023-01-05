FROM node:18-alpine
ENV CI=true

RUN apk update
RUN apk add nano openssl

WORKDIR /app/api
COPY ./api .
RUN npm install --silent --legacy-peer-deps

CMD ["npm", "run", "dev"]
# ENTRYPOINT ["tail", "-f", "/dev/null"]