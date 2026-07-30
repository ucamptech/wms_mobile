const { WmsAppHelper } = require('../helpers/app');

const app = new WmsAppHelper();

describe('Operations', () => {
  before(async () => {
    await app.loginWithCredentials();
  });

  it('completes the Receive flow', async () => {
    await app.completeReceiveFlow();
  });

  it('completes the Putaway flow', async () => {
    await app.completePutawayFlow();
  });

  it('completes the Pick flow', async () => {
    await app.completePickFlow();
  });

  it('shows an error for an unknown barcode', async () => {
    await app.openReceiveOperation();
    await app.enterTextInLastInputField('BAD-CODE');
    await app.tapConfirmButton();
    await app.waitForPartialTextOnScreen('Unknown barcode');
    await app.closeOperationScreen();
  });

  it('shows an error when barcode is empty', async () => {
    await app.openPickOperation();
    await app.tapConfirmButton();
    await app.waitForPartialTextOnScreen('Scan or enter a barcode');
    await app.closeOperationScreen();
  });

  it('shows an error for an unknown bin', async () => {
    await app.openPutawayOperation();
    await app.enterTextInLastInputField('SKU-10042');
    await app.tapConfirmButton();
    await app.waitForTextOnScreen('FOUND');
    await app.enterTextInLastInputField('WRONG-BIN');
    await app.tapSubmitButton();
    await app.waitForPartialTextOnScreen('Unknown bin');
    await app.closeOperationScreen();
  });

  it('goes back from step 2 to step 1', async () => {
    await app.openReceiveOperation();
    await app.enterTextInLastInputField('PO-2024-0889');
    await app.tapConfirmButton();
    await app.waitForTextOnScreen('FOUND');
    await app.tapBackButton();
    await app.waitForTextOnScreen('Confirm');
    await app.closeOperationScreen();
  });

  it('accepts a custom quantity on Receive', async () => {
    await app.completeReceiveFlow('PO-2024-0889', 7);
  });
});
