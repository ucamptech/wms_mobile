FROM ghcr.io/cirruslabs/flutter:stable AS build
WORKDIR /app
RUN yes | flutter doctor --android-licenses || true
COPY . .
RUN flutter pub get && flutter build apk --release

FROM alpine:3.20
WORKDIR /apk
COPY --from=build /app/build/app/outputs/flutter-apk/ ./
CMD ["sh", "-c", "cp -r /apk/. /output && ls /output"]
