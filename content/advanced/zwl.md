---
title: Import from ZecWallet Lite
weight: 20
---

You can import your wallet keys from ZWL directly
into YWallet without needing to synchronize ZWL.

This can be useful when ZWL fails to open.

ZecWallet Lite is not responsive until it is fully 
synced up. If your wallet cannot be synced, you will
not be able to operate ZWL. For example, it may get 
appear stuck on the loading screen.

However, `zecwallet-lite-cli` the command line version
of ZWL has an option to by-pass synchronization.

- [Download](https://github.com/adityapk00/zecwallet-light-cli/releases) ZWL-cli for your platform,
- Uncompress and install
- Open a shell/command prompt/terminal
- Launch ZWL-cli with the nosync option and export your
wallet to a file

On Windows,
```text
zecwallet-cli.exe --nosync export > wallet.zwl
```

## Import your ZWL key file

- In YWallet, go to the account manager, and *long-press*
the "+" button

{{< img 2022-07-15_10-02-45.png >}}

- Choose "Restore Batch"

{{< img Screenshot_20220403-144800.jpg >}}

- Leave the Backup Encryption Key field empty
- Load your ZWL key file

Your **shielded** addresses will be added to YWallet.

{{%notice note %}}
Transparent addresses are not imported.
{{%/notice %}}

## Demo

{{%youtube Shvfdx4aZwM %}}

<link href="/youtube.css" rel=stylesheet integrity>
<script src="/youtube.js"></script>
