---
layout: default
title: Auto-Shield Transparent Balance
parent: Advanced Usage
nav_order: 1.2
---

The Auto-Shield feature automatically transfers your transparent
balance to the shielded address when it is greater than a 
configurable amount.

It runs when it detects a change in your balance and
schedules a transaction immediately. 

![Shield](img/IMG_0088.PNG)

1. Auto-Shield threshold. A value of 0 disables auto shielding
2. By default, shield when you pay. It can be overridden 
in the "advanced options" section of the Send page

## Remarks

- If you set a low threshold, it may make a lot of transactions
- However, if the threshold is high, your transparent balance could remain
unshielded for a long time
- Each transaction costs 0.01 mZEC (or mYEC)
- You can manually shield by tapping the button "Shield Transparent Balance"
on the Transparent Account page
- With option 2, the recipient of the payment can infer that the 
transparent address belongs to you