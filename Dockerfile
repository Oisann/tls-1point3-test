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
WORKDIR /app/certs
COPY certs/ /app/certs/
COPY --from=BUILDER /app/main /app
WORKDIR /app
EXPOSE 443
CMD ["./main"]