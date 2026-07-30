const { WmsAppHelper } = require('../helpers/app');

const app = new WmsAppHelper();

describe('Full flow', () => {
  it('logs in, runs all operations, then logs out', async () => {
    await app.loginWithCredentials();
    await app.waitForTextOnScreen('SELECT OPERATION');

    await app.completeReceiveFlow();
    await app.completePutawayFlow();
    await app.completePickFlow();

    await app.logoutFromApp();
    await app.waitForTextOnScreen('LOG IN');
  });
});
