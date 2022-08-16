---
title: Synchronization
weight: 25
---

{{%img 2022-07-22_16-18-02.png %}}

Synchronization (Catchup) will automatically start when YWallet
detects that it does not have the latest block data.

You can also manually trigger a rescan through the application menu.

## Statistics

During Rescan or Catchup, the blockheight will cycle between
the following information:
- current height / latest height
{{%img 2022-07-22_16-27-57.png %}}

- synchronization %
{{%img 2022-07-22_16-23-18.png %}}

- number of blocks remaining to process
{{%img 2022-07-22_16-23-25.png %}}

- timestamp of latest block processed
{{%img 2022-07-22_16-23-34.png %}}

- ETA (Estimated Time Remaining to complete the scan)
{{%img 2022-07-22_16-23-45.png %}}

- Bytes downloaded from the server
{{%img 2022-08-16_23-09-52.png %}}

- Number of transaction outputs decrypted
{{%img 2022-08-16_23-09-33.png %}}


{{%notice note%}}
Tapping on the display will alternate between cycling and
a fixed display.
{{%/notice%}}

## Remarks

- You can use the "Bytes downloaded from the server" statistics
to monitor the status of the remote server. If there is no
progress for more than a minute, it is a good indication that
the server is not responding.

- "Number of transaction outputs decrypted" shows how many
trial decryption YWallet has done so far. Synchronization
speed is significantly reduced by trial decryptions.

- If these two statistics reset to 0, the server has disconnected.
YWallet will automatically reconnect but there may be some network 
issue.

## Pause/Resume

The synchronization can be canceled/paused through the Application Menu.
When paused, automatic catchup is also disabled.
To resume the scan, either tap on the message or choose the 
"Resume Scan" option in the application menu.

{{%img 2022-07-22_16-32-42.png %}}

{{%notice note%}}
Pausing the synchronization is not immediate. YWallet will not
download more data from the server but will complete processing
the data it currently has.
{{%/notice%}}

