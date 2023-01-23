FROM golang:1.17.6-alpine3.15 as builder

WORKDIR /workspace
COPY go.mod go.mod
COPY go.sum go.sum

RUN apk add --no-cache libgit2 libgit2-dev git gcc g++ pkgconfig

RUN go mod download

COPY main.go main.go

ARG TARGETARCH TARGETOS

RUN cat /etc/apk/arch 

RUN CGO_ENABLED=1 GO111MODULE=on GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -tags static,system_libgit2 -a -o gitoperations main.go

FROM alpine:3.15 as runner

WORKDIR /
COPY --from=builder /workspace/gitoperations .
ENTRYPOINT ["/gitoperations"]