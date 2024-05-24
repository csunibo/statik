FROM golang:alpine AS go-builder
COPY . /build
WORKDIR /build
RUN go build -ldflags "-s -w" -o /build/statik

FROM scratch
COPY --from=go-builder /build/statik /usr/bin/statik
COPY --from=go-builder /build/page.gohtml /opt/page.gohtml
COPY --from=go-builder /build/style.css /opt/style.css

ENTRYPOINT ["/usr/bin/statik"]
