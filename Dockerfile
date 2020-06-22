FROM golang:latest AS BUILDER
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:3.12 as CERTS
WORKDIR /certs
RUN openssl ecparam -out ec_key.pem -name secp256r1 -genkey
RUN openssl req -new -key ec_key.pem -x509 -nodes -days 365 -out cert.pem

FROM alpine:3.12
RUN apk add -U --no-cache ca-certificates
WORKDIR /app
WORKDIR /app/certs
COPY --from=BUILDER /app/main /app
COPY --from=CERTS /ec_key.pem /app/certs
COPY --from=CERTS /cert.pem /app/certs
WORKDIR /app
EXPOSE 8080
CMD ["./main"]