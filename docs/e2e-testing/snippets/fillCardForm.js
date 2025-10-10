/**
 * fillCardForm.js
 *
 * 決済フォーム入力をフォールバックで補助するスニペット。
 * 通常操作が連続失敗した場合にのみ、1回だけ実行される想定。
 */
async function fillCardForm(page, card) {
  const {
    number = '4242 4242 4242 4242',
    expiry = '12 / 34',
    cvc = '123',
    holder = 'AI Test User',
    postal = '100-0001',
  } = card || {};

  await page.waitForSelector('input[name="cardNumber"]', { state: 'visible' });
  await page.fill('input[name="cardNumber"]', number);

  await page.waitForSelector('input[name="cardExpiry"]', { state: 'visible' });
  await page.fill('input[name="cardExpiry"]', expiry);

  await page.waitForSelector('input[name="cardCvc"]', { state: 'visible' });
  await page.fill('input[name="cardCvc"]', cvc);

  await page.waitForSelector('input[name="cardHolder"]', { state: 'visible' });
  await page.fill('input[name="cardHolder"]', holder);

  await page.waitForSelector('input[name="postalCode"]', { state: 'visible' });
  await page.fill('input[name="postalCode"]', postal);
}

module.exports = { fillCardForm };
