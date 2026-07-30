const { BaseHelper } = require('./base_helper');

class AuthHelper extends BaseHelper {
  async resetAppToLoginScreen() {
    await driver.execute('mobile: clearApp', {
      appId: 'com.example.wms_mobile',
    });
    await driver.execute('mobile: activateApp', {
      appId: 'com.example.wms_mobile',
    });
    await this.waitForAppReady();
    await this.waitForTextOnScreen('LOG IN', 20000);
  }

  async isLogoutDialogVisible() {
    return (
      (await this.isTextVisible('Sign out', 1200)) ||
      (await this.isTextVisible('Cancel', 1200))
    );
  }

  async tapLogoutIconByBounds() {
    const { width, height } = await driver.getWindowSize();
    const clickables = await $$('//*[@clickable="true"]');

    let best = null;
    let bestX = -1;

    for (const element of clickables) {
      const center = await this.getElementCenter(element);
      if (!center) {
        continue;
      }

      const inTopBar = center.y < height * 0.18;
      const onRight = center.x > width * 0.72;

      if (inTopBar && onRight && center.x > bestX) {
        bestX = center.x;
        best = element;
      }
    }

    if (!best) {
      return false;
    }

    await best.click();
    await driver.pause(700);
    return this.isLogoutDialogVisible();
  }

  async openLogoutDialog() {
    if (await this.tapLogoutIconByBounds()) {
      return true;
    }

    const { width, height } = await driver.getWindowSize();
    const tapPoints = [
      [0.93, 0.055],
      [0.93, 0.065],
      [0.93, 0.075],
      [0.93, 0.085],
      [0.93, 0.095],
      [0.90, 0.080],
      [0.96, 0.080],
    ];

    for (const [xPercent, yPercent] of tapPoints) {
      await this.tapAtCoordinates(width * xPercent, height * yPercent);
      await driver.pause(700);
      if (await this.isLogoutDialogVisible()) {
        return true;
      }
    }

    return false;
  }

  async logoutFromApp() {
    const dialogOpened = await this.openLogoutDialog();

    if (dialogOpened) {
      await this.tapOnPartialText('Sign out');
      await this.waitForTextOnScreen('LOG IN', 15000);
      return;
    }

    await this.resetAppToLoginScreen();
  }

  async cancelLogoutDialog() {
    const dialogOpened = await this.openLogoutDialog();
    if (!dialogOpened) {
      throw new Error('Could not open logout dialog to cancel');
    }
    await this.tapOnText('Cancel');
    await this.waitForTextOnScreen('SELECT OPERATION', 10000);
  }

  async loginWithCredentials(username = 'r.santos', password = 'demo') {
    await this.waitForAppReady();

    if (await this.isHomeScreenVisible()) {
      await this.logoutFromApp();
    }

    await this.waitForTextOnScreen('LOG IN', 20000);

    const fields = await this.getTextInputFields();
    await this.enterTextInField(fields[0], username);
    await this.enterTextInField(fields[1], password);

    await this.tapOnText('LOG IN');
    await this.waitForTextOnScreen('SELECT OPERATION', 25000);
  }
}

module.exports = { AuthHelper };
