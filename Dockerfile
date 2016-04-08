# rust tooling is provided by `archlinux-rust`
FROM cnivolle/archlinux-rust
MAINTAINER Geoffroy Couprie, contact@geoffroycouprie.com

# needed by rust
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# relevant files are in `./source`
ADD . /source
WORKDIR /source

# Clever Cloud expects your app to listen on port 8080
EXPOSE 8080

RUN rustc -V

# Build your application
RUN cargo build

# Run the application with `CMD`
CMD cargo run
CMD /start

