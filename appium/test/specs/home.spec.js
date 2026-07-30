const { WmsAppHelper } = require('../helpers/app');

const app = new WmsAppHelper();

describe('Home', () => {
  before(async () => {
    await app.loginWithCredentials();
  });

  it('shows operation cards and activity stats', async () => {
    await app.waitForTextOnScreen('SELECT OPERATION');
    await app.waitForTextOnScreen('Receive');
    await app.waitForTextOnScreen('Putaway');
    await app.waitForTextOnScreen('Pick');
    await app.waitForTextOnScreen("TODAY'S ACTIVITY");
  });

  it('opens Stock and Log tabs', async () => {
    await app.tapOnText('Stock');
    await app.waitForTextOnScreen('Stock lookup');

    await app.tapOnText('Log');
    await app.waitForTextOnScreen('Activity log');

    await app.tapOnText('Scan');
    await app.waitForTextOnScreen('SELECT OPERATION');
  });

  it('cancels the logout dialog', async () => {
    await app.cancelLogoutDialog();
  });

  after(async () => {
    await app.logoutFromApp();
  });
});
