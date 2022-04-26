---
layout: default
title: Internal Format
weight: 50
---

In order to support messages with subject and sender, 
YWallet formats the memo field in a particular way.
Other wallets will see messages as this:

```txt
🛡MSG
ys19xxuxdrw07fjz6j0u0cfcfeczg04pfupcm7pae0tyy4qn0wzmsp87nntfmlkxu2tcqz4xsy9exf
hey
Wanna get brunch on Sunday? 
```

The first line `🛡MSG` indicates that it is a YWallet shielded message.
The second line is the address of the sender. The later may choose to remain
anonymous, in which case this line is empty.
The third line is the subject of the message.
The remainer is the body/content.

For messages that are not sent from YWallet, YWallet makes a message
with no sender and which subject is the first ~20 characters of the body.
