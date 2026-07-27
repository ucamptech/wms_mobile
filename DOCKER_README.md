# wms_mobile

WMS mobile app.

## Build APK with Docker

### First time

1. Open Docker Desktop. Wait until it is running.
2. Open PowerShell.
3. Go to the project folder:

```powershell
cd C:\Users\user\Desktop\Work\wms_mobile
```

4. Run this command:

```powershell
docker compose up --build
```

5. Wait for it to finish.
6. Find the APK here: `apk_out\app-debug.apk`

### 2nd or more time

1. Open Docker Desktop.
2. Go to Containers.
3. Find `wms_mobile`.
4. Press Play.
5. If you changed the code, press Rebuild and start.
6. Get the APK from `apk_out\app-debug.apk`
