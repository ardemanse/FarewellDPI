chcp 65001
pushd "%~dp0"
del /F /Q logfile.log

:: -=-=-=-=-=-=-=-=-=-=-= Edit strategies here -=-=-=-=-=-=-=-=-=-=-= ::
set TLS443=--dpi-desync=fake,multisplit --dpi-desync-repeats=3 --dpi-desync-fake-tls="%~dp0fake\tls13_clienthello_vk_com.bin" --dpi-desync-fake-tls-mod=rnd,dupsid --dpi-desync-fake-tls="%~dp0fake\tls13_clienthello_api_vk_com.bin" --dpi-desync-fake-tls-mod=rnd,dupsid --dpi-desync-split-seqovl=476 --dpi-desync-split-seqovl-pattern="%~dp0fake\tls13_clienthello_api_vk_com.bin" --dpi-desync-split-pos=62,sniext,host+2,sld-3,sld+2,midsld,endsld-1,endsld+2,-17 --dpi-desync-fooling=datanoack,badseq --dpi-desync-badseq-increment=0x80000000

set QUIC443=--dpi-desync=fake,ipfrag2 --dpi-desync-repeats=5 --dpi-desync-fake-quic="%~dp0fake\quic_initial_vk_com.bin" --dpi-desync-ipfrag-pos-udp=32

set DISCORDSTUN50000=--dpi-desync=fake --dpi-desync-repeats=2 --dpi-desync-fake-discord="%~dp0fake\quic_short_header.bin" --dpi-desync-fake-stun="%~dp0fake\quic_short_header.bin"
:: -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= ::

set ARGS=--wf-tcp=443 --wf-udp=443,50000-50099 --filter-tcp=443 --hostlist="%~dp0lists\blacklist.txt" --hostlist="%~dp0lists\customhostlist.txt" %TLS443% --new --filter-tcp=443 --hostlist="%~dp0lists\youtube.txt" %TLS443% --new --filter-tcp=443 --hostlist-auto="%~dp0lists\autohostlist.txt" --hostlist-exclude="%~dp0lists\exclude.txt" %TLS443% --new --filter-udp=443 %QUIC443% --new --filter-udp=50000-50099 --filter-l7=discord,stun %DISCORDSTUN50000%

set ARGS=%ARGS:"=\"%

call :srvinst zapret
goto :eof

:srvinst
net stop %1 >>logfile.log
sc delete %1 >>logfile.log
sc create %1 binPath= "\"%~dp0\bin\winws.exe\" %ARGS%" DisplayName= "FarewellDPI : %1" start= auto >>logfile.log
sc description %1 "FarewellDPI. Have fun in The Internet!" >>logfile.log
sc start %1 >>logfile.log