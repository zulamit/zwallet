---
title: Warp Sync
weight: 70
pre: <svg class="icon"><use xlink:href="/sprite.svg#rabbit"></use></svg>
---

## What's so important about Synchronization?

If your wallet is slow, it is most likely because of synchronization.

Wallets need to keep up with the latest data from the blockchain. This process is called synchronization and differs greatly between privacy coins and regular coins.

Light wallets do not have the entire blockchain data. They rely on a server to give them enough information to rebuild the account balance and transaction history.

With non-privacy coins, servers can index the blockchain and keep a database of every account. When light wallets ask them for their specific account data, the server retrieves the information and directly returns it to the client.

However, this is not possible with privacy coins. They encrypt or shield the transactions recorded on the blockchain and prevent any external entity from knowing their details.

Light wallets can either:
- download and decrypt the blockchain data themselves. But they would not be "light" anymore.
- or send their decryption key (i.e. the viewing key) and let the server filter the transactions. But it reduces the user's privacy because now, the server has the viewing key.

Zcash (and its forks) implements a mixed approach. A specialized server called `lightwalletd` filters the data from a full node `zcashd` and keeps only the data needed for transaction identification.

Light wallets only have to download the trimmed data (Compact Blocks). Then they decrypt these compact blocks themselves.

Yet, even decrypting and processing compact blocks can take a significant amount of time. 

## What's Warp Sync? Explain Like I'm 5

Synchronization in other wallets works by processing transactions one by one. With Warp Sync, YWallet can process multiple transactions together.

Here's an analogy. Let's say you want to calculate $1+2+3+4+5+6+...+1000$.

We can perform the series of additions and keep a partial sum. $1+2 = 3$. Then $3+3 = 6$, and $6+4 = 10$, etc.
Eventually, we will reach $1000$ and have our total sum.

However, when we notice that 

$$
\begin{aligned}
1 + 1000 &= 2 + 999 \cr
&= 3 + 998 \cr
&= 4 + 997 \cr
\end{aligned}
$$

we can calculate *twice* the desired value as follows,

$$
\begin{aligned}
(1+\dots+1000) \times 2 &= (1+1000) + (2+999) + \dots \cr
&= 1001 \times 1000 \cr
\end{aligned}
$$

And our result is 

$$
\frac{1001 \times 1000}{2}
$$

Just by rearranging the terms of our calculation, we were able
to get a massive performance boost.

{{%notice note %}}
Warp Sync skips the intermediate results and 
jumps straight to the final result.
{{%/notice %}}

This is just an **analogy**. Zcash synchronization is much more complex. Warp Sync still has to do a lot of computation.

## If that sounds too good to be true

It's because it's not exactly true. Warp Sync still has to perform a number of hash calculations proportional to the number of shielded transaction outputs. However, the usual synchronization method needs several times more than that.

## Any drawback?

Not really, in the end the result is identical bit by bit. We don't have the intermediate values but we don't need them anyway.

## How fast is WarpSync compared to Normal Sync

The benchmark consists of restoring a wallet from seed and 
resynchronizing from the first block.

In this benchmark, Warp Sync runs 300 times faster than Normal Sync.

- [Nighthawk (NH) Benchmark](https://www.youtube.com/watch?v=doJeDS-zAV8&t=4427s): 12 hours 30 minutes
- [Ywallet (YW) Benchmark](https://www.youtube.com/shorts/1AmoaQmj5Zk): 2 minutes


This chart shows the synchronization progress in % per second. 
A value of 100 means the speed is 100% per second, i.e. 
the synchronization takes 1 second.

Speed varies because some blocks have more transactions than others.

- NH is in blue and YW is in  red.
- Higher values mean better performance
- Note that the Y-scale is *logarithmic*. 

{{<img "benchmark.svg" >}}

{{%notice note %}}
Performance varies with wallets and hardware. Your experience may differ but you should see a significant improvement nonetheless.
We benchmarked Nighthawk because it uses the classic 
synchronization method. Unstoppable, Edge, etc. are also using
the same algorithm and show similar results.
{{%/notice %}}


## Other Performance Optimizations

- Warp Sync has a custom implementation of the Hash algorithm for an extra few percent speed up 
- It leverages batch trial decryption for another few percentage points.
- It implements a streaming processing pipeline which can maximize your download speed and
keep all your CPU cores fully utilized.
- The pipeline downloads and processes a moving window of the compact blockchain. It limits memory usage to a minimum.
