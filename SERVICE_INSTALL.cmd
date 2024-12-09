chcp 65001
pushd "%~dp0"
del /F /Q logfile.log

:: Edit strategies here ::
set DISQ50000=--dpi-desync=fake --dpi-desync-fake-quic="%~dp0fake\quic_initial_vk_com.bin" --dpi-desync-cutoff=d2 --dpi-desync-any-protocol --dpi-desync-repeats=3
set AUTO443=--dpi-desync=fake,fakeddisorder --dpi-desync-fake-tls="%~dp0fake\tls_clienthello_dzen_ru.bin" --dpi-desync-fakedsplit-pattern="%~dp0fake\tls_clienthello_dzen_ru.bin" --dpi-desync-split-seqovl=2 --dpi-desync-split-pos=midsld+3 --dpi-desync-fooling=md5sig,badseq --dpi-desync-autottl=1 --dpi-desync-repeats=3
set YT443=--dpi-desync=fake,fakedsplit --dpi-desync-fake-tls="%~dp0fake\tls_clienthello_www_google_com.bin" --dpi-desync-fakedsplit-pattern="%~dp0fake\tls_clienthello_www_google_com.bin" --dpi-desync-split-seqovl=1 --dpi-desync-split-pos=sniext --dpi-desync-fooling=md5sig --dpi-desync-autottl=1 --dpi-desync-repeats=6
set YTDISQ443=--dpi-desync=fake,udplen --dpi-desync-fake-quic="%~dp0fake\quic_initial_www_google_com.bin" --dpi-desync-udplen-increment=10 --dpi-desync-udplen-pattern=0xDEADBEEF --dpi-desync-cutoff=n2 --dpi-desync-repeats=6
set BLACKLIST443=--dpi-desync=fake,fakedsplit --dpi-desync-fake-tls="%~dp0fake\tls_clienthello_dzen_ru.bin" --dpi-desync-fakedsplit-pattern="%~dp0fake\tls_clienthello_dzen_ru.bin" --dpi-desync-split-seqovl=2 --dpi-desync-split-pos=sld+2 --dpi-desync-fooling=md5sig,datanoack --dpi-desync-autottl=1 --dpi-desync-repeats=3
set BLACKLIST80=--dpi-desync=fake,fakedsplit --dpi-desync-split-pos=method+3 --dpi-desync-fooling=md5sig,datanoack
:: Edit strategies end ::

set ARGS=--wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-udp=443 --hostlist="%~dp0lists\youtubeQ.txt" --hostlist="%~dp0lists\discord.txt" %YTDISQ443% --new --filter-tcp=443 --hostlist="%~dp0lists\youtube.txt" %YT443% --new --filter-tcp=80 --hostlist="%~dp0lists\blacklist.txt" %BLACKLIST80% --new --filter-tcp=443 --hostlist="%~dp0lists\blacklist.txt" --hostlist-exclude="%~dp0lists\exclude.txt" --hostlist="%~dp0lists\customhostlist.txt" --hostlist="%~dp0lists\discord.txt" %BLACKLIST443% --new --filter-udp=50000-50099 %DISQ50000% --new --filter-tcp=443 --hostlist-auto="%~dp0lists\autohostlist.txt" --hostlist-exclude="%~dp0lists\exclude.txt" %AUTO443%
set ARGS=%ARGS:"=\"%

call :srvinst zapret
goto :eof

:srvinst
net stop %1 >>logfile.log
sc delete %1 >>logfile.log
sc create %1 binPath= "\"%~dp0\bin\winws.exe\" %ARGS%" DisplayName= "FarewellDPI : %1" start= auto >>logfile.log
sc description %1 "FarewellDPI. Have fun in The Internet!" >>logfile.log
sc start %1 >>logfile.log