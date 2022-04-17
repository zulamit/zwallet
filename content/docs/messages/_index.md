---
layout: default
title: Messages
weight: 2.2
has_children: true
---

Your messages are listes in the "Messages" tab. 
The badge indicates how many messages are new and unread.

{{< img_index 2022-04-17_17-47-15.png >}}

Messages are contained in the memo field.
Whenever you send to a *shielded* address, you can
attach some data through the memo.

Memos have a maximum size of 512 bytes which is enough
in most cases.

## Implementation

In order to support messages with subject and sender, 
YWallet formats the memo field in a particular way.
Other wallets will see messages as this:

```
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
