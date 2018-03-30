FROM golang:1.9.2-alpine

RUN apk add --update tzdata \
    git;
    
# Install fresh that brings reload functionality
RUN go get github.com/pilu/fresh

CMD fresh
