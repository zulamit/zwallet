---
title: Documentation
type: docs
---

## Summary

- Fastest synchronization of all the wallets on the market
- Private Message Center
- Supports every feature of ycash and zcash
- Track your wallet performance and expenditures
- Watch-only and Cold Wallet

[More features]({{< relref "/features" >}})

## Screenshots

{{< img3 2022-04-21_13-59-56.png >}}
{{< img3 2022-04-21_14-03-00.png >}}
{{< img3 2022-04-21_14-05-34.png >}}
{{< img3 2022-04-21_14-10-40.png >}}
{{< img3 2022-04-21_14-11-20.png >}}
{{< img3 2022-04-21_14-12-41.png >}}

## BACKUP REMINDER (VERY IMPORTANT!)

**ALWAYS KEEP A BACKUP** of your account keys in a safe place. 
- This wallet is non-custodian and no one else has your account data. Bad things can happen! 
- Make sure you have the recovery backup available before you upgrade

> The best backup is the one you have and never used. The worst backup is the one you need and never made.

## 10 Wallet Tips

1. YWallet is available on Mobile (Android & iOS) and desktop
(Windows, Mac & Linux): [Download](../download)
2. Keep your contacts in the address book: [Contacts](./contact). It will help
identify addresses in the transaction history.
3. Maintain both Ycash and Zcash accounts. Your accounts are
independent and can have different seeds and keys. [Accounts](./account)
4. The [Message](./messages/center) tab is a convenient way to check your messages in one place.
4. Tap QR code to switch between shielded and transparent address
5. If you want to merge the balance of several accounts, use diversified addresses instead of creating multiple shielded addresses
6. Keep a few notes ready to be spent to avoid having to wait for confirmations.
[Coin Control](./advanced/coin-control) and [Split Notes](./advanced/advanced-send)
7. If you are trading, check out the Wallet P/L charts
8. You can transfer between accounts by using their names instead of their addresses
9. You can navigate prev/next through the [transaction details](./account/transactions)

## Getting Started

Please follow this [link](getting-started)

## FAQ

1. Does it support transparent addresses?

   Yes, but we highly recommend shielding these coins before spending them.
   The app is Shielded by Default.
  
2. How fast is the synchronization exactly?

   It depends on the hardware but for average phones, Y/ZWallet scans the entire blockchain
   (as of Sep 2021) in around 1-3 minutes. In the end, your account balances are 
   fully available to spend. The reference wallet SDK is 100x slower.
   
3. Why the name Y/ZWallet and WarpWallet? 

   There are different versions of the app for Ycash and Zcash. The app was
   initially built for Zcash and was called ZWallet. Then it was ported to Ycash
   and named YWallet.
   Unfortunately, the name ZWallet is taken on the Apple Store and the app
   had to be rebranded WarpWallet.
   
   A single version that supports both coins may be implemented in the future.
   
4. Is it open source?
   
   Yes, the source code is available on [github](https://github.com/hhanh00/zwallet).
   
5. Why is it not listed on the Zcash website?

   The source code is pending review by the Zcash team.
   However, it has been reviewed by the Ycash team and is listed on the Ycash 
   Foundation website.
   
6. Does it collect data?

   *Absolutely no user data is collected*. The wallet only connects to a `lightwalletd` server
   (by default the officially sponsored server) and CoinGecko for market prices.

7. Can it connect to any lightwalletd?

   Yes, the wallet uses the standard API of lightwalletd. It can connect to 
   ZecWallet version of lightwalletd or your own deployment.
 
8. Can I receive my mining rewards in my transparent address?

   It is best not to receive your mining rewards because they need to mature
   for 100 blocks before they can be spent. The Y/ZWallet cannot
   shield your balance if any of the UTXO is not old enough. Currently,
   `lightwalletd` does not provide an API to get the UTXO age and the
   shielding transaction will be rejected by the network.

9. How can I keep my account safe?

   The number one reason for lost coins is failure to have a *backup* of the 
   seed phrase.
   
   Please, **DO A BACKUP ASAP** and make sure that it is kept in a 
   safe place away from spying eyes.
   
   *All the application data can be recovered from the seed phrase!*
   
   **Do not share your seed phrase with other people!**
