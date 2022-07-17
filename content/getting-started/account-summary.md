---
layout: default
title: Account summary
parent: Getting Started
nav_order: 2
weight: 20
---

## Shielded Mode

{{< img IMG_0041.PNG >}}

1. Address QR Code
2. Address (middle part elided)
3. Copy address to clipboard
4. Show address QR Code full screen without other data
5. Account Balance (up to 1/1000 of a coin)
6. Remaining part of the Account balance (below 1/1000 coin)
7. Press to generate a new (diversified) address
8. Press to go to the send page
9. Balance in Fiat currency and Exchange Rate

### Notes

- Diversified (or snap addresses) show up for a few seconds. Then
the account reverts to the primary address. They can still be used
afterward
- If the device is tilted forward, the page switches to "Receive Mode"
- You can choose the Fiat currency on the settings page

## Synchronization

During Rescan or Catchup, the blockheight will cycle between
the following information:
- current height / latest height
- synchronization %
- number of blocks remaining
- timestamp of latest block processed
- ETA

{{%notice note%}}
Tapping on the display will alternate between cycling and
a fixed display.
{{%/notice%}}

## Receive Mode

{{< img IMG_0039.PNG >}}


1. The account balance is hidden. 
2. The QR Code is rotated 180 degrees to facilitate scanning by a person in front of you.

This function can be turned off in the settings.

## Transparent Address Mode

{{< img IMG_0040.PNG >}}

Your account is *primary* shielded: Most functions affect the shielded address.
 
However, there is a transparent address associated with each account that can be used to receive coins. 

> Tap the QR code to switch between Transparent and Shielded Mode

1. The QR code of the transparent address
2. The transparent address
3. The balance on the transparent address. **This balance cannot be spent directly**
unless you enable "Spend from Transparent Balance".
The coins should be first transferred to the shielded address.
4. Press to initiate shielding of the current balance

