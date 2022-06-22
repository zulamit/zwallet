---
layout: default
title: Cold Storage
parent: Advanced Usage
weight: 5
---

In a cold storage transaction, the mobile account does not have
the secret key needed for spending.
However, it is able to build an unsigned transaction and export
it as a file.

The account owner moves the file to another computer that holds
the secret key (preferably offline and air-gapped for security).

On the offline computer, he signs the transaction and generate
a now valid transaction that he saves to another file.

After importing the later into the Y/ZWallet, the transaction
is finalized and broadcast.

This workflow ensures that the secret key never leave the computer
that is isolated from the Internet.

[Cold Storage in the context of Bitcoin](https://en.bitcoin.it/wiki/Cold_storage)

The same concept is applicable to Zcash.

## QR codes or Files

{{< img2 2022-06-21_17-27-37.png >}}

- Choose QR codes if your signing device and your cold wallets have
cameras and are in close proximity,
- Use files otherwise

## Preparing the unsigned transaction

If the account does not have a secret key either because it was restored
from viewing key or because it was converted to Cold Storage,
the button Send is dimmed. Instead of signing and broadcasting a transaction,
the Send page prepares an unsigned transaction.

### QR Code

If you enabled the "Use QR codes for offline signing",
you will get an animated QR code:

{{< img2 2022-06-21_17-26-12.png >}}

{{%notice note%}}
The transaction is too large to fit in a single QR code. YWallet uses
animated QR codes with error correction (RaptorQ).
{{%/notice %}}

### Files

Depending on your phone OS, you can save the unsigned transaction to
a USB key, or to the Cloud.

The transaction file must be copied to the computer that has the `sign`
application.

{{< img IMG_0094.PNG >}}

## Sign

There are two options for signing the transaction. You can either use
a command line tool (with no GUI) or use another phone/device with 
YWallet that you keep offline.

{{%notice note%}}
We recommend using another phone as the signer. Please, make sure that it was
factory reset and that it was never connected to the Internet.
{{%/notice %}}

### Command Line Tool

You can build the `sign` app from its [source code](https://github.com/hhanh00/zcash-sync)

To run the `sign` app, you need to create an `.env` file that has
a line

```
KEY="<seed or secret-key>"
```

For example,

```
KEY="human tissue pony dose host stamp tag hockey begin wisdom humble divorce goose grief analyst hard axis fiscal flat cloud huge pair sunset into"
```

Then run the signer as follows:

```sh
sign <unsigned filename> <signed filename>
```

For example,

```sh
sign tx.json tx.raw
```

Then copy `tx.raw` back to a USB drive (or Cloud storage)

## Offline Ywallet

{{< img2 2022-06-21_17-55-21.png >}}

Use the "Sign" menu. It will ask you to open the unsigned transaction file
and proceed to sign it. If the current account contains the secret key
it will create a raw transaction and offer you to save it.

### QR Code

Point your camera and scan the animated QR code. Every time a QR code is captured,
your phone will make a little "click". Once all the data is read, the wallet
will display the details of the transaction.

{{< img2 2022-06-22_8-42-42.png >}}


Make sure that the information is valid.

Then tap to Sign the transaction and produce an animated QR code for it.

## Broadcast

{{< img IMG_0095.PNG >}}
{{< img IMG_0097.PNG >}}
{{< img IMG_0098.PNG >}}

1. Select "Broadcast" from the app menu
2. Pick up the raw transaction file from the storage (or point your camera
to scan the animated QR code)
3. Wait for the transaction id

## Remarks

- USB drive is safer than Cloud storage but in any case, the files
do not contain any information that could be used to reveal your secret key
- Do not send the unsigned transaction without authentication over a unsecure
channel. An attacker could *modify* the payment information and make the signer
sign a different transaction!

{{%notice warning %}}
You should use GPG to encrypt and sign your transaction if you
transmit it over an unsecure channel.
{{%/notice %}}

## Demo

[Youtube video](https://www.youtube.com/watch?v=Z5yXXHjjWNQ&t=547s)
