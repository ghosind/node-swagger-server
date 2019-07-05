# generate server code
FROM swaggerapi/swagger-codegen-cli:latest AS codegen

WORKDIR /data

COPY swagger.json .

RUN java -jar /opt/swagger-codegen-cli/swagger-codegen-cli.jar generate -i swagger.json -l nodejs-server -o out

# api server
FROM node:10-alpine

WORKDIR /api/src

COPY --from=codegen /data/out .

EXPOSE 8080

CMD ["npm", "start"]
