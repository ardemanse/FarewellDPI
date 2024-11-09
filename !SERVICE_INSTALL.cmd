chcp 65001
pushd "%~dp0"
del /F /Q logfile.log

:: Edit strategies here ::
set DISQ50000=--dpi-desync=fake --dpi-desync-fake-quic="%~dp0quic_initial_vk_com.bin" --dpi-desync-cutoff=d2 --dpi-desync-any-protocol --dpi-desync-repeats=3
set AUTO443=--dpi-desync=fake,split2 --dpi-desync-split-seqovl=3 --dpi-desync-split-tls=sniext --dpi-desync-fake-tls="%~dp0tls_clienthello_vk_com.bin" --dpi-desync-fooling=md5sig,badseq --dpi-desync-autottl=1
set YT443=--dpi-desync=fake,split2 --dpi-desync-fake-tls="%~dp0tls_clienthello_www_google_com.bin" --dpi-desync-split-seqovl=1 --dpi-desync-ttl=3
set YTDISQ443=--dpi-desync=fake,udplen --dpi-desync-udplen-increment=10 --dpi-desync-udplen-pattern=0xDEADBEEF --dpi-desync-fake-quic="%~dp0quic_initial_www_google_com.bin" --dpi-desync-cutoff=n2 --dpi-desync-repeats=5
set GV443=--dpi-desync=split --dpi-desync-split-pos=1 --dpi-desync-fooling=badseq --dpi-desync-repeats=8 --dpi-desync-ttl=4
set BLACKLIST443=--dpi-desync=fake,split2 --dpi-desync-fake-tls="%~dp0tls_clienthello_vk_com.bin" --dpi-desync-split-seqovl=224 --dpi-desync-split-seqovl-pattern="%~dp0tls_clienthello_vk_com.bin" --dpi-desync-fooling=md5sig,badseq
set BLACKLIST80=--dpi-desync=fake,split2 --dpi-desync-fooling=md5sig
:: Edit strategies end ::

set ARGS=--wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-udp=443 --hostlist="%~dp0youtubeQ.txt" --hostlist="%~dp0discord.txt" %YTDISQ443% --new --filter-tcp=443 --hostlist="%~dp0googlevideo.txt" %GV443% --new --filter-tcp=443 --hostlist="%~dp0youtube.txt" %YT443% --new --filter-tcp=80 --hostlist="%~dp0blacklist.txt" %BLACKLIST80% --new --filter-tcp=443 --hostlist="%~dp0blacklist.txt" --hostlist="%~dp0customhostlist.txt" --hostlist="%~dp0discord.txt" %BLACKLIST443% --new --filter-udp=50000-50099 %DISQ50000% --new --filter-tcp=443 --hostlist-auto="%~dp0autohostlist.txt" %AUTO443%
set ARGS=%ARGS:"=\"%

call :srvinst zapret
goto :eof

:srvinst
net stop %1 >>logfile.log
sc delete %1 >>logfile.log
sc create %1 binPath= "\"%~dp0winws.exe\" %ARGS%" DisplayName= "FarewellDPI : %1" start= auto >>logfile.log
sc description %1 "FarewellDPI. Have fun in The Internet!" >>logfile.log
sc start %1 >>logfile.log
