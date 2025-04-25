chcp 65001
pushd "%~dp0"
del /F /Q logfile.log

:: -=-=-=-=-=-=-=-=-=-=-= Edit strategies here -=-=-=-=-=-=-=-=-=-=-= ::
set BLACKLIST80=--dpi-desync=multisplit --dpi-desync-repeats=3 --dpi-desync-split-pos=7,method+2,host+4,-32

set BLACKLIST443=--dpi-desync=multisplit --dpi-desync-split-seqovl=496 --dpi-desync-split-seqovl-pattern="%~dp0fake\tls_clienthello_ads_vk_com_tls12.bin" --dpi-desync-split-pos=sld-20,sld-14,sld-9,sld-5,sld-2,sld,midsld-1,midsld,midsld+2,endsld,endsld+2,endsld+4,endsld+8,endsld+16,endsld+32

set QUIC443=--dpi-desync=fake,ipfrag2 --dpi-desync-repeats=8 --dpi-desync-fake-quic="%~dp0fake\quic_initial_vk_com.bin" --dpi-desync-ipfrag-pos-udp=32

set DISQ50000=--dpi-desync=fake,udplen --dpi-desync-repeats=4 --dpi-desync-fake-unknown-udp="%~dp0fake\quic_short_header.bin" --dpi-desync-udplen-increment=8 --dpi-desync-udplen-pattern=0xDEADBEEF --dpi-desync-any-protocol --dpi-desync-cutoff=d2
:: -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= ::

set ARGS=--wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --hostlist="%~dp0lists\blacklist.txt" --hostlist="%~dp0lists\customhostlist.txt" --hostlist-exclude="%~dp0lists\exclude.txt" %BLACKLIST80% --new --filter-tcp=443 --hostlist="%~dp0lists\blacklist.txt" --hostlist="%~dp0lists\customhostlist.txt" --hostlist="%~dp0lists\discord.txt" --hostlist="%~dp0lists\youtube.txt" %BLACKLIST443% --new --filter-tcp=443 --hostlist-auto="%~dp0lists\autohostlist.txt" --hostlist-exclude="%~dp0lists\exclude.txt" %BLACKLIST443% --new --filter-udp=443 %QUIC443% --new --filter-udp=50000-50099 %DISQ50000%

set ARGS=%ARGS:"=\"%

call :srvinst zapret
goto :eof

:srvinst
net stop %1 >>logfile.log
sc delete %1 >>logfile.log
sc create %1 binPath= "\"%~dp0\bin\winws.exe\" %ARGS%" DisplayName= "FarewellDPI : %1" start= auto >>logfile.log
sc description %1 "FarewellDPI. Have fun in The Internet!" >>logfile.log
sc start %1 >>logfile.log