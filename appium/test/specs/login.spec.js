const { WmsAppHelper } = require('../helpers/app');

const app = new WmsAppHelper();

describe('Login', () => {
  before(async () => {
    await app.waitForAppReady();
  });

  it('shows the login screen', async () => {
    await app.waitForTextOnScreen('WMS Mobile');
    await app.waitForTextOnScreen('LOG IN');
  });

  it('logs in with demo credentials', async () => {
    await app.loginWithCredentials('r.santos', 'demo');
    await app.waitForTextOnScreen('SELECT OPERATION');
  });

  it('logs out successfully', async () => {
    await app.logoutFromApp();
    await app.waitForTextOnScreen('LOG IN');
  });
});
