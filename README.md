# A universal censorship bypassing tool
FarewellDPI is designed to spoof Deep Packet Inspection (DPI) systems which are used for restricting access to Internet resources.

# Installation
1) TURN OFF YOUR ANTIVIRUS!!! Antiviruses, including Windows Defender, will most likely remove critical files which are REQUIRED for FarewellDPI to operate. This is a common issue with similar tools which intercept and modify network packets.
2) Make sure you aren't using your ISP's DNS servers. Better use DNS-over-HTTPS instead.
3) Extract the FarewellDPI.zip into disk C:\
4) Open the extracted folder and run SERVICE_INSTALL.cmd as Admin.
Done! You should now be able to access restricted websites.

# Modifying DPI fooling strategies
While it's likely that FarewellDPI will unblock access to YouTube, Discord, Twitter (X) and other websites, it's still not guaranteed. Different ISPs use different "breeds" of DPI. Fooling strategies may vary depending on your ISP.
You can manually edit the fooling strategies in SERVICE_INSTALL.cmd.
[List of all available arguments](https://github.com/bol-van/zapret/blob/master/docs/readme.en.md#nfqws)

```
set TLS443=[Arguments for all blocked websites on HTTPS/TLS]
set QUIC443=[Arguments for all QUIC connections]
set DISCORDSTUN50000=[Arguments for Discord voice]
```

# Editing host lists
Host lists can be found in /FarewellDPI/lists/. While adding a new domain to any list, follow these rules:
1) Always enter one domain per line.
2) Don't put any spaces.

```
blacklist.txt — Primary list of blocked domains.
customhostlist.txt — Secondary list of blocked domains. Add your domains here.
autohostlist.txt — Automatic list of blocked domains. Adds a website after several unsuccessful connection attempts.
youtube.txt — YouTube domains.
exclude.txt — Domains which should be ignored by FarewellDPI even if they are unreachable.
```
