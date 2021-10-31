---
layout: default
title: Release Notes
nav_order: 5
---

## 1.0.12

> **IMPORTANT NOTICE**

If you have received notes from YWallet after height 1046400 (Thu, 28 Oct 2021 21:26:48 UTC),
you have to move them out to a **transparent address** before you upgrade.

### How to upgrade

1. DO A BACKUP OF YOUR SEED/SECRET KEY if you haven't done it already
2. If you don't have have any notes after 1046400 skip to 4.
3. Send these notes to a TRANSPARENT address that you own. DO NOT USE A SHIELDED ADDRESS!
4. Upgrade to 1.0.12
5. If you did step 3, transfer the funds from the transparent address back to your wallet

### Explanation of the issue

YWallet has incorrectly activated Canopy ZIP 212 on the Ycash branch at the same 
height as Zcash. It expects and creates notes with the new format. Unfortunately,
this is not detected by the protocol rules and transactions are mined.

> These notes are not visible by the other wallets. They cannot be spent by 
them *and* by YWallet after the fix.

Only YWallet 1.0.11 and below can see and spend these notes. Therefore they
must be transferred to a **transparent address** before upgrading.

Do not transfer to a shielded address because it would create another note with
the same issue.

If you upgrade without transferring these notes, you will need to rollback
to version 1.0.11 and rescan your wallet.

**YOUR FUNDS ARE NOT LOST**
