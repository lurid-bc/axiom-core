# Build Step
FROM rust:buster AS builder

ARG DATABASE_URL
ENV DATABASE_URL = $DATABASE_URL

WORKDIR /app

COPY . .

RUN cargo build --release

# Production Step
FROM rust:slim-buster

WORKDIR /usr/local/bin

COPY --from=builder /app/target/release/axiom-core .

CMD [ "./axiom-core" ]