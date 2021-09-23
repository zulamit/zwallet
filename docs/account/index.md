---
layout: default
title: Accounts
nav_order: 2
has_children: true
---

Y/ZWallet supports one or many **accounts**. 
Each account has a shielded and transparent **address** (unless it was restored from a secret key).

An address has zero or more **notes**. For shielded accounts, notes are encrypted and only visible to the
account owner. Transparent addresses have notes in cleartext.

A note is conceptually an "I Owe You". It can have any amount greater than zero (including zero).
The account balance is the sum of all the note amounts.

When you pay, you take one or many notes and spend them to create new notes that 
the recipient can later use. This forms a **transaction**.

Transactions are broadcast to the network and relayed between nodes. 
Eventually, they are picked up by a miner that includes them in the blockchain.

Until then, a transaction is *unconfirmed*. If a transaction is in
the latest block, it has *one* confirmation. If it is included in the 
previous block, it has *two* confirmations, etc. The more confirmations
it has, the less likely it can be reverted. 

Notes are always fully used. They cannot be split. In practice, it is not an issue because you
can create new notes for yourself. For more information, check the UTXO entry in
[Wikipedia](https://en.wikipedia.org/wiki/Unspent_transaction_output).

The app displays the various elements mentioned above in its UI as follows:

- Accounts are on the Account Manager page,
- Addresses are shown in the Account tab,
- Notes are shown in the Notes tab,
- Transactions are shown in the History tab.
