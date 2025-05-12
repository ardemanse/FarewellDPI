# Make your Internet free again!
FarewellDPI is designed to spoof Deep Packet Inspection (DPI) systems which are used for restricting access to Internet resources.

# Installation
1) TURN OFF YOUR ANTIVIRUS!!! Antiviruses, including Windows Defender, will most likely remove critical files which are REQUIRED for FarewellDPI to operate. This is a common issue with similar tools which intercept and modify data packets.
2) Extract the FarewellDPI.zip into disk C:\
3) Open the extracted folder and run SERVICE_INSTALL.cmd as Admin.
4) Make sure you aren't using your ISP's DNS servers. Better use DNS-over-HTTPS instead.
5) Done! You may now enjoy the free Internet!

# Modifying DPI fooling strategies
While it's very likely that FarewellDPI will unblock access to YouTube, Discord, Twitter (X) and other websites, it's not guaranteed.
Different ISPs use different "breeds" of DPI. Fooling strategies may vary depending on your ISP.
You can manually edit the fooling strategies in SERVICE_INSTALL.cmd.
[List of all available arguments](https://github.com/bol-van/zapret/blob/master/docs/readme.en.md#nfqws)

```
set TLS443_A=[Arguments for blocked domains from main host lists, HTTPS/TLS]
set TLS443_B=[Arguments for YouTube domains, HTTPS/TLS]
set QUIC443=[Arguments for all QUIC connections]
set DISCORDSTUN50000=[Arguments for Discord voice]
```

# Manipulating host lists
Host lists can be found in /FarewellDPI/lists/. While adding a new domain to any list, follow these rules:
1) Always enter one domain per line.
2) Don't put any spaces.

```
blacklist.txt — Primary list of blocked domains.
customhostlist.txt — Secondary list of blocked domains. Is meant to be edited by users.
autohostlist.txt — Automatic list of unreachable domains.
youtube.txt — YouTube domains.
exclude.txt — A list of excluded domains. Edit this file if certain domains are constantly being falsely added to autohostlist.txt.
```
