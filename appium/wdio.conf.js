const path = require('path');
const fs = require('fs');

function resolveApk() {
  if (process.env.APK_PATH && fs.existsSync(process.env.APK_PATH)) {
    return path.resolve(process.env.APK_PATH);
  }

  const root = path.resolve(__dirname, '..');
  const apkBuild = [
    path.join(root, 'apk_out', 'app-release.apk'),
    path.join(root, 'apk_out', 'app-debug.apk'),
    path.join(root, 'build', 'app', 'outputs', 'flutter-apk', 'app-release.apk'),
    path.join(root, 'build', 'app', 'outputs', 'flutter-apk', 'app-debug.apk'),
  ];

  const found = apkBuild.find((p) => fs.existsSync(p));
  if (!found) {
    throw new Error(
      'APK not found. Build first, or set APK_PATH to your .apk file.',
    );
  }
  return found;
}

exports.config = {
  runner: 'local',
  specs: ['./test/specs/**/*.spec.js'],
  maxInstances: 1,
  capabilities: [
    {
      platformName: 'Android',
      'appium:automationName': 'UiAutomator2',
      'appium:deviceName': process.env.DEVICE_NAME || 'Android Emulator',
      'appium:app': resolveApk(),
      'appium:appPackage': 'com.example.wms_mobile',
      'appium:appActivity': '.MainActivity',
      'appium:autoGrantPermissions': true,
      'appium:noReset': false,
      'appium:newCommandTimeout': 240,
      'appium:disableWindowAnimation': true,
      'appium:settings[waitForIdleTimeout]': 100,
    },
  ],
  logLevel: process.env.LOG_LEVEL || 'warn',
  outputDir: './logs',
  waitforTimeout: 15000,
  connectionRetryTimeout: 120000,
  services: [
    [
      'appium',
      {
        args: {
          relaxedSecurity: true,
          log: './logs/appium-server.log',
        },
        logPath: './logs',
      },
    ],
  ],
  framework: 'mocha',
  reporters: ['spec'],
  mochaOpts: {
    ui: 'bdd',
    timeout: 180000,
  },
};
