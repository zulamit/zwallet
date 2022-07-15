---
layout: default
title: Sub-Account
parent: Advanced Usage
weight: 6
---

## Main Account

Your main account is displayed in **bold face**.
There is one main account for each coin. When you spend
and receive coins from the dashboard shortcuts, the funds
will be directed to the main account.

The main account is the last account you selected for that
particular coin.

{{< img Screenshot_20220403-144433.jpg >}}

## Sub Accounts

A seed phrase can derive a multitude of accounts. By default, 
Ywallet uses only the *first* account. 

However, if you want to create additional accounts with the 
same seed, you can tell it to use additional account indexes.

The first account is at index 0.

To create a sub-account for the current selected account, *long press*
the '+' button, and select "New Sub-account".

{{< img 2022-07-15_10-02-45.png >}}

You'll be asked to provide a new name:

{{< img 2022-07-15_9-50-20.png >}}

You can increase the "Count" number if you need more 
sub-accounts.

{{%notice info%}}
Ywallet recommends using a seed per account and not 
using sub-accounts. This feature is intended for cases when you need
to recover accounts from other wallets.
Since shielded addresses are not visible on the blockchain,
there is no advantage in using more than one address. 
In case you want to give out a unique address, diversified addresses
(or snap addresses in Ywallet) offer a better scalable solution.
{{%/notice %}}

## Backup

The backup of a sub-account contains the account index. This index
is needed for recovery but it is not part of the seed phrase.

Ywallet detects this format automatically but be aware that other
wallets will not consider it valid.

{{< img Screenshot_20220403-144639.jpg >}}

