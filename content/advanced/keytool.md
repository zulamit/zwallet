---
title: Key Tool
weight: 30
---

{{< img 2022-07-27_10-39-08.png >}}

The Key Tool is a transparent & secret key derivation tool based
on BIP32/39/44 and ZIP32.

It is similar to the [Mnemonic Code Converter](https://iancoleman.io/bip39/) but built specifically for Zcash and Ycash.

With the Key Tool, you can extract 
the private keys of most (all?) wallets,
as long as they use a **seed phrase**.

- Ledger, Coinomi,
- Edge,
- Nighthawk,
- ZecWallet Lite
- Zcash (HDSeed),
- etc.

However, the derivation path they use varies from wallet to wallet.

## Transparent Wallets

Transparent Wallets follow BIP32/44 and derive the secret key at
`m/44'/133'/account'/external/address` (133 is for Zcash)

For example, the external address #2 of account #5
is at `m/44'/133'/5'/0/2'`.
The change address is at `m/44'/133'/5'/1/2'`

Usually, they increase the address index automatically
to avoid reusing the same address.
The account index is incremented when the user creates
a new account for the same currency.

## Shielded Wallets

Shielded Wallets follow ZIP32 and derive the secret key at
either
`m/44'/133'/account'` or `m/44'/133'/account'/address`

If you leave the address field *empty*, the Key Tool
will generate the first type of path.

## Special Note for Zcashd

Zcashd has support for ZIP316 (Unified Addresses)
and generates its legacy sapling addresses
backward from the end to avoid clashing with UA.

Therefore the first sapling address in Zcashd 5.0.0
is at index 2,147,483,647 and then will go down.

Pre-5.0.0 addresses are not supported.

## Usage

Once you have the secret keys you can import them
into YWallet as regular accounts.

{{%notice note %}}
Using the Key Tool requires fingerprint/pin authentication.
{{%/notice %}}
