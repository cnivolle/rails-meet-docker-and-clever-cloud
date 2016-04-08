# rust tooling is provided by `archlinux-rust`
FROM geal/archlinux-rust
MAINTAINER Geoffroy Couprie, contact@geoffroycouprie.com

# needed by rust
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# relevant files are in `./source`
ADD . /source
WORKDIR /source

# Clever Cloud expects your app to listen on port 8080
EXPOSE 8080

#Datadog
RUN echo "<<=== Start DD install ===>>"
RUN DD_API_KEY=64b9c0afcea4940746506697bd9849f4 sh -c "$(curl -L https://raw.githubusercontent.com/DataDog/dd-agent/master/packaging/datadog-agent/source/setup_agent.sh)"
RUN echo "<<=== END install ===>>"

RUN rustc -V

# Build your application
RUN cargo build

# Run the application with `CMD`
CMD cargo run
CMD /start

