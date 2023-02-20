FROM golang:1.20-alpine3.17 AS builder

WORKDIR /app
COPY go.mod ./
RUN GOSUMDB=off go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GOPROXY=direct GOSUMDB=off go build -o main .

# final stage
FROM alpine:3.17 as production
WORKDIR /app
COPY --from=builder /app/main .
ENTRYPOINT ["/app/main"]

# expose port 8000
EXPOSE 8000
