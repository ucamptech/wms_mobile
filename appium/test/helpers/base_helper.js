class BaseHelper {
  buildTextSelectors(text) {
    return [
      `android=new UiSelector().text("${text}")`,
      `android=new UiSelector().textContains("${text}")`,
      `android=new UiSelector().description("${text}")`,
      `android=new UiSelector().descriptionContains("${text}")`,
      `//*[@text="${text}"]`,
      `//*[contains(@text, "${text}")]`,
      `//*[@content-desc="${text}"]`,
      `//*[contains(@content-desc, "${text}")]`,
    ];
  }

  async elementExists(selectors, timeout = 2000) {
    const endTime = Date.now() + timeout;

    while (Date.now() < endTime) {
      for (const selector of selectors) {
        const matches = await $$(selector);
        if (matches.length > 0) {
          return matches[0];
        }
      }
      await driver.pause(250);
    }

    return null;
  }

  async findVisibleElement(selectors, timeout = 15000) {
    const element = await this.elementExists(selectors, timeout);
    if (!element) {
      throw new Error(
        `Could not find visible element. Tried:\n- ${selectors.join('\n- ')}`,
      );
    }
    return element;
  }

  async waitForTextOnScreen(text, timeout = 15000) {
    return this.findVisibleElement(this.buildTextSelectors(text), timeout);
  }

  async waitForPartialTextOnScreen(text, timeout = 15000) {
    return this.findVisibleElement(this.buildTextSelectors(text), timeout);
  }

  async isTextVisible(text, timeout = 2000) {
    const element = await this.elementExists(
      this.buildTextSelectors(text),
      timeout,
    );
    return Boolean(element);
  }

  async tapOnText(text, timeout = 15000) {
    const element = await this.waitForTextOnScreen(text, timeout);
    await element.click();
  }

  async tapOnPartialText(text, timeout = 15000) {
    const element = await this.waitForPartialTextOnScreen(text, timeout);
    await element.click();
  }

  async tapAtCoordinates(x, y) {
    await driver.execute('mobile: clickGesture', {
      x: Math.floor(x),
      y: Math.floor(y),
    });
  }

  async dismissKeyboardIfOpen() {
    const isOpen = await driver.isKeyboardShown();
    if (!isOpen) {
      return;
    }
    await driver.hideKeyboard();
  }

  async getTextInputFields(timeout = 10000) {
    const endTime = Date.now() + timeout;

    while (Date.now() < endTime) {
      const fields = await $$('android.widget.EditText');
      if (fields.length) {
        return fields;
      }
      await driver.pause(300);
    }

    throw new Error('No EditText fields found on screen');
  }

  async enterTextInField(field, value) {
    await field.waitForDisplayed({ timeout: 10000 });
    await field.click();
    await field.clearValue();
    await field.setValue(value);
    await this.dismissKeyboardIfOpen();
  }

  async enterTextInLastInputField(value) {
    const fields = await this.getTextInputFields();
    await this.enterTextInField(fields[fields.length - 1], value);
  }

  async waitForAppReady() {
    await driver.pause(1500);
    await driver.updateSettings({
      waitForIdleTimeout: 100,
      waitForSelectorTimeout: 2000,
    });
  }

  async isHomeScreenVisible() {
    return this.isTextVisible('SELECT OPERATION', 2500);
  }

  async getElementCenter(element) {
    try {
      const location = await element.getLocation();
      const size = await element.getSize();
      return {
        x: location.x + size.width / 2,
        y: location.y + size.height / 2,
      };
    } catch (error) {
      console.warn(`Could not read element bounds: ${error.message}`);
      return null;
    }
  }
}

module.exports = { BaseHelper };
