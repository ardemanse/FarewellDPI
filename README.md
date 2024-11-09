# Make your Internet free again!
FarewellDPI is designed for fooling Deep Packet Inspection (DPI) systems which are used for restricting access to Internet websites

# Installation
1) TURN OFF YOUR ANTIVIRUS!!! Antiviruses, including Windows Defender, will most likely remove critical files which are REQUIRED for FarewellDPI to operate.
2) Extract the FarewellDPI.zip into disk C:\
3) Open the extracted folder and run !SERVICE_INSTALL.cmd as Admin
4) Make sure you aren't using your ISP's DNS servers. Instead, set your DNS to 1.1.1.1 and 8.8.8.8 (CloudFlare and Google)
Done! You may now enjoy the free Internet!

# Configuration
While it's very likely that FarewellDPI will unblock access to YouTube, Discord, Twitter (X) and other websites, it's still possible for it to fail.
Different ISPs use different "breeds" of DPI. Some fooling strategies may work for one, but not for the others.
You can manually edit the fooling strategies in !SERVICE_INSTALL.cmd:

***
- set DISQ50000=[Arguments for Discord voice]
- set AUTO443=[Arguments for domains which were automatically flagged as blocked]
- set YT443=[Arguments for YouTube]
- set YTDISQ443=[Arguments for YouTube and Discord on UDP 443]
- set GV443=[Arguments for YouTube's googlevideo.com domain]
- set BLACKLIST443=[Arguments for blocked domains from blacklist.txt and Discord on TCP 443]
- set BLACKLIST80=[Arguments for blocked domains from blacklist.txt and Discord on TCP 80]
***

[List of all available arguments](https://github.com/ardemanse/zapret/blob/master/docs/readme.en.md#nfqws)
