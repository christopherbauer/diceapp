FROM node:19-alpine
ENV CI=true

RUN apk update
RUN apk add nano openssl

WORKDIR /app/api
COPY ./api .
RUN npm install

CMD ["npm", "run", "dev"]
# ENTRYPOINT ["tail", "-f", "/dev/null"]