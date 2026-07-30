const { AuthHelper } = require('./auth_helper');

class OperationHelper extends AuthHelper {
  async openReceiveOperation() {
    await this.tapOnText('Scan inbound items from PO');
    await this.waitForPartialTextOnScreen('SCAN PO', 10000);
  }

  async openPutawayOperation() {
    await this.tapOnText('Assign items to bin location');
    await this.waitForPartialTextOnScreen('SCAN ITEM', 10000);
  }

  async openPickOperation() {
    await this.tapOnText('Fulfill outbound order items');
    await this.waitForPartialTextOnScreen('SCAN ORDER', 10000);
  }

  async openCloseIconOnOperation() {
    const { width, height } = await driver.getWindowSize();
    const clickables = await $$('//*[@clickable="true"]');
    let best = null;
    let bestX = Number.POSITIVE_INFINITY;

    for (const element of clickables) {
      const center = await this.getElementCenter(element);
      if (!center) {
        continue;
      }

      if (
        center.y < height * 0.18 &&
        center.x < width * 0.25 &&
        center.x < bestX
      ) {
        bestX = center.x;
        best = element;
      }
    }

    if (best) {
      await best.click();
      await driver.pause(700);
      if (await this.isHomeScreenVisible()) {
        return;
      }
    }

    const tapPoints = [
      [0.06, 0.055],
      [0.06, 0.065],
      [0.06, 0.075],
      [0.08, 0.070],
    ];

    for (const [xPercent, yPercent] of tapPoints) {
      await this.tapAtCoordinates(width * xPercent, height * yPercent);
      await driver.pause(700);
      if (await this.isHomeScreenVisible()) {
        return;
      }
    }

    await driver.back();
    await this.waitForTextOnScreen('SELECT OPERATION', 10000);
  }

  async tapConfirmButton() {
    await this.tapOnText('Confirm');
  }

  async tapSubmitButton() {
    await this.tapOnText('Submit');
  }

  async tapDoneButton() {
    await this.tapOnPartialText('Done');
  }

  async tapBackButton() {
    await this.tapOnPartialText('Back');
  }

  async closeOperationScreen() {
    await this.openCloseIconOnOperation();
    await this.waitForTextOnScreen('SELECT OPERATION', 10000);
  }

  async completeReceiveFlow(barcode = 'PO-2024-0889', quantity) {
    await this.openReceiveOperation();
    await this.enterTextInLastInputField(barcode);
    await this.tapConfirmButton();
    await this.waitForTextOnScreen('FOUND');

    if (quantity != null) {
      await this.enterTextInLastInputField(String(quantity));
    }

    await this.tapSubmitButton();
    await this.waitForPartialTextOnScreen('units received');
    await this.tapDoneButton();
    await this.waitForTextOnScreen('SELECT OPERATION');
  }

  async completePutawayFlow(sku = 'SKU-10042', binCode = 'BIN CODE') {
    await this.openPutawayOperation();
    await this.enterTextInLastInputField(sku);
    await this.tapConfirmButton();
    await this.waitForTextOnScreen('FOUND');
    await this.enterTextInLastInputField(binCode);
    await this.tapSubmitButton();
    await this.waitForPartialTextOnScreen('Bin');
    await this.tapDoneButton();
    await this.waitForTextOnScreen('SELECT OPERATION');
  }

  async completePickFlow(orderCode = 'SO-2024-1198') {
    await this.openPickOperation();
    await this.enterTextInLastInputField(orderCode);
    await this.tapConfirmButton();
    await this.waitForTextOnScreen('FOUND');
    await this.tapSubmitButton();
    await this.waitForPartialTextOnScreen('units picked');
    await this.tapDoneButton();
    await this.waitForTextOnScreen('SELECT OPERATION');
  }
}

module.exports = { OperationHelper };
