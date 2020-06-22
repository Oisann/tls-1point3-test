FROM golang:latest AS BUILDER
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:3.12
RUN apk add -U --no-cache ca-certificates
#RUN apk upgrade --update-cache --available && \
#    apk add openssl && \
#    rm -rf /var/cache/apk/*
WORKDIR /app
COPY certs/ /app
COPY --from=BUILDER /app/main /app
COPY --from=CERTS /ec_key.pem /app/certs
COPY --from=CERTS /cert.pem /app/certs
WORKDIR /app
EXPOSE 8080
CMD ["./main"]