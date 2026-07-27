FROM ghcr.io/cirruslabs/flutter:stable AS build
WORKDIR /app
ARG BUILD_MODE=release
RUN yes | flutter doctor --android-licenses || true
COPY . .
RUN flutter pub get && flutter build apk --${BUILD_MODE}

FROM alpine:3.20
WORKDIR /apk
COPY --from=build /app/build/app/outputs/flutter-apk/ ./
CMD ["sh", "-c", "cp -r /apk/. /output && ls /output"]
