---
layout: default
title: Send coins
parent: Getting Started
nav_order: 4
weight: 40
---

{{< img IMG_0043.PNG >}}

1. Start from the account page by clicking on the "Send" button in the bottom right corner

{{< img IMG_0125.PNG >}}

1. Address to send coins to
2. Tap to open the QR code scanner
3. Either enter the amount in mZEC or 
4. Enter the amount in Fiat currency. The other field updates automatically
5. Tap to spend the entire balance
6. Show/Collapse advanced options
7. Tap to send.

## Detailed balances

{{< img IMG_0125_1.PNG >}}

1. Total balance available = transparent + shielded
2. Shielded [NOTES]({{<relref notes>}}) that don't have enough confirmations for sending 
3. Shielded notes that were excluded from sending ([COIN CONTROL]({{<relref coin-control>}}))
4. Transparent balance. These coins must be shielded before sending. Tap the
shield button to initiate the transfer to your shielded address
5. Remaining balance spendable (taking the network fee into consideration)

## Remarks

- The spendable balance excludes the network fee of 0.01 mY/ZEC. 
- Notes may not be spendable if they were received recently.
In this case, wait for more confirmations or change the setting
"Number of Confirmations Needed before Spending". 
- Lowering the value increases the risk of having the transaction reverted.
- By default, the balance in the transparent address cannot be spent. 
Refer to [Use Transparent Balance]({{<relref advanced-send>}}) to enable 
spending from it.
