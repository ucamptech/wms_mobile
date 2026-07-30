# Appium tests (WMS Mobile)

## Setup

1. Build an APK (`apk_out\app-release.apk` or debug)
2. Start an Android emulator (or connect a phone)
3. Install deps:

```powershell
cd appium
npm install
```

## Run

```powershell
npm test
```

Single suites:

```powershell
npm run test:login
npm run test:home
npm run test:ops
npm run test:full
```