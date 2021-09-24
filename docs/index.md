---
layout: default
title: Y/ZWallet
nav_order: 0
---

<p align="center">
    <h1 align="center">Y/ZWallet</h1>
    <p align="center">The fastest, most advanced, shielded wallet for Zcash and Ycash</p>
	<div align="center"><img src="IMG_0115.PNG"></div>
</p>

---


## Download 

### YWallet

<a href="https://play.google.com/store/apps/details?id=me.hanh.ywallet"><img style="height:74px" src="google-play-badge.png"></a>
<a href="https://apps.apple.com/us/app/ywallet/id1583859229"><img style="height:50px;margin-bottom:12px" src="apple-store-badge.svg"></a>

### ZWallet

TBD

## At a glance

- Fastest synchronization of all the wallets on the market
- Supports every feature of *shielded y/zcash*
- Track your wallet performance and expenditures
- Watch-only and Cold Wallet

[More features](features)

## Getting Started

Please follow this [link](getting-started)

## FAQ

1. Does it support transparent addresses?

   Yes, but coins received in transparent addresses cannot be directly spent and must
   be shielded first.
  
2. How fast is the synchronization exactly?

   It depends on the hardware but for average phones, Y/ZWallet scans the entire blockchain
   (as of Sep 2021) in around 1-3 minutes. In the end, your account balances are 
   fully available to spend. The reference wallet SDK is 100x slower.
   
3. Why the name Y/ZWallet? 

   There are different versions of the app for Ycash and Zcash. 
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
