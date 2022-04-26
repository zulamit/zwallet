---
title: FAQ
weight: 80
---

1. Does it support transparent addresses?

   Yes, but we highly recommend shielding these coins before spending them.
   The app is Shielded by Default.
  
2. How fast is the synchronization exactly?

   It depends on the hardware but for average phones, YWallet scans the entire blockchain
   (as of Sep 2021) in around 1-3 minutes. In the end, your account balances are 
   fully available to spend. The reference wallet SDK is 100x slower.
   
3. Was there a ZWallet and WarpWallet? 

   There used to be different versions of the app for Ycash and Zcash. The app was
   initially built for Zcash and was called ZWallet. Then it was ported to Ycash
   and named YWallet.
   Unfortunately, the name ZWallet is taken on the Apple Store and the app
   had to be rebranded WarpWallet.
   
   Now we have a single version that works for both Ycash and Zcash and the app
   ZWallet is discontinued.
   
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
   
   {{% notice warning %}}
   Please, **DO A BACKUP ASAP** and make sure that it is kept in a 
   safe place away from spying eyes.
   {{% /notice %}}
   
   *All the application data can be recovered from the seed phrase!*
   
   **Do not share your seed phrase with other people!**