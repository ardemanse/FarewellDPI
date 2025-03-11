# Make your Internet free again!
FarewellDPI is designed to spoof Deep Packet Inspection (DPI) systems which are used for restricting access to Internet websites.

# Installation
1) TURN OFF YOUR ANTIVIRUS!!! Antiviruses, including Windows Defender, will most likely remove critical files which are REQUIRED for FarewellDPI to operate. This is a common issue with alike services which intercept and modify data packets.
2) Extract the FarewellDPI.zip into disk C:\
3) Open the extracted folder and run SERVICE_INSTALL.cmd as Admin.
4) Make sure you aren't using your ISP's DNS servers. Instead, set your DNS to 1.1.1.1 and 8.8.8.8 (CloudFlare and Google).
5) Done! You may now enjoy the free Internet!

# Modifying DPI fooling strategies
While it's very likely that FarewellDPI will unblock access to YouTube, Discord, Twitter (X) and other websites, it's still possible for it to fail.
Different ISPs use different "breeds" of DPI. Some fooling strategies may work for one, but not for the others.
You can manually edit the fooling strategies in SERVICE_INSTALL.cmd.
[List of all available arguments](https://github.com/bol-van/zapret/blob/master/docs/readme.en.md#nfqws)

```
set BLACKLIST80=[Arguments for blocked domains from blacklist.txt and Discord on TCP 80]
set BLACKLIST443=[Arguments for blocked domains from blacklist.txt and Discord on TCP 443]
set AUTO443=[Arguments for domains which were automatically flagged as blocked]
set YT443=[Arguments for YouTube on TCP 443]
set QUIC443=[Arguments for QUIC protocol on UDP 443]
set DISQ50000=[Arguments for Discord voice]
```

# Manipulating host lists
Host lists can be found in /FarewellDPI/lists/. While adding a new domain to any list, follow these rules:
1) Always enter one domain per line.
2) Don't put any spaces.

```
blacklist.txt — Primary list of blocked domains. Strategy code: BLACKLIST443 for HTTPS, BLACKLIST80 for HTTP.
customhostlist.txt — Secondary list of blocked domains. Strategy code: BLACKLIST443 for HTTPS, BLACKLIST80 for HTTP.
autohostlist.txt — Automatic list of blocked domains, detects and adds banned websites on its own. Strategy code: AUTO443 for HTTPS.
youtube.txt — YouTube domains. Strategy code: YT443 for HTTPS.
discord.txt — Discord domains. Strategy code: BLACKLIST443 for HTTPS.
exclude.txt — A list of excluded domains. Use this file if there are domains which are constantly being falsely added to autohostlist.txt.
```
