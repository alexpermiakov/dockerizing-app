FROM golang:1.23-bookworm AS base

WORKDIR /app

RUN useradd -u 1001 nonroot

COPY go.mod go.sum ./

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    go mod download

COPY . .

FROM base AS development

RUN go install github.com/air-verse/air@latest && \
  go install github.com/go-delve/delve/cmd/dlv@latest

EXPOSE 8080

CMD ["air", "-c", ".air.toml"]

FROM base AS production-build

RUN go build \
  -ldflags "-linkmode external -extldflags -static" \
  -tags netgo \
  -o main main.go

FROM scratch as production

ENV GIN_MODE=release

COPY --from=production-build /etc/passwd /etc/passwd
COPY --from=production-build /app/main /main

USER nonroot

EXPOSE 8080

CMD ["/main"]