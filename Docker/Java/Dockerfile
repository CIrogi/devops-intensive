FROM azul/zulu-openjdk:22-jdk-crac AS builder

ADD HelloWorld.java /usr/src/myapp/
WORKDIR /usr/src/myapp
RUN javac HelloWorld.java

FROM azul/zulu-openjdk:22-jre
COPY --from=builder /usr/src/myapp/HelloWorld.class /usr/local/bin/HelloWorld.class
WORKDIR /usr/local/bin/
CMD ["java", "HelloWorld"]

