chcp 65001
pushd "%~dp0"
del /F /Q logfile.log

:: -=-=-=-=-=-=-=-=-=-=-= Edit strategies here -=-=-=-=-=-=-=-=-=-=-= ::
set MAIN_TLS443=--dpi-desync=fake,multisplit --dpi-desync-repeats=2 --dpi-desync-fake-tls="%~dp0fake\tls13_clienthello_vk_com.bin" --dpi-desync-fake-tls-mod=rnd,dupsid --dpi-desync-fake-tls="%~dp0fake\tls13_clienthello_api_vk_com.bin" --dpi-desync-fake-tls-mod=rnd,dupsid,padencap --dpi-desync-split-seqovl=487 --dpi-desync-split-seqovl-pattern="%~dp0fake\tls13_clienthello_api_vk_com.bin" --dpi-desync-split-pos=sniext,sniext+2,host+1,sld-2,midsld-3,midsld,endsld-2,endsld+2 --dpi-desync-fooling=datanoack,badseq --dpi-desync-badseq-increment=0x80000000

set YT_TLS443=--dpi-desync=fake,multisplit --dpi-desync-repeats=2 --dpi-desync-fake-tls="%~dp0fake\tls13_clienthello_drive_google_com.bin" --dpi-desync-fake-tls-mod=rnd,dupsid --dpi-desync-fake-tls="%~dp0fake\tls13_clienthello_mail_google_com.bin" --dpi-desync-fake-tls-mod=rnd,dupsid,padencap --dpi-desync-split-seqovl=493 --dpi-desync-split-seqovl-pattern="%~dp0fake\tls13_clienthello_mail_google_com.bin" --dpi-desync-split-pos=sniext,host+1,host+5,midsld-3,midsld,midsld+2,endsld-3,endsld+2 --dpi-desync-fooling=datanoack,badseq --dpi-desync-badseq-increment=0x80000000

set QUIC443=--dpi-desync=fake,ipfrag2 --dpi-desync-repeats=5 --dpi-desync-fake-quic="%~dp0fake\quic_initial_vk_com.bin" --dpi-desync-ipfrag-pos-udp=32

set DISCORDSTUN50000=--dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fake-discord="%~dp0fake\quic_short_header.bin" --dpi-desync-fake-stun="%~dp0fake\quic_short_header.bin" --dpi-desync-udplen-increment=8 --dpi-desync-udplen-pattern=0xDEADBEEF
:: -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= ::

set ARGS=--wf-tcp=443 --wf-udp=443,50000-50099 --filter-tcp=443 --hostlist="%~dp0lists\zapret-hosts-main.txt" --hostlist="%~dp0lists\zapret-hosts-user.txt" %MAIN_TLS443% --new --filter-tcp=443 --hostlist="%~dp0lists\zapret-hosts-google.txt" %YT_TLS443% --new --filter-udp=443 %QUIC443% --new --filter-udp=50000-50099 --filter-l7=discord,stun %DISCORDSTUN50000%

set ARGS=%ARGS:"=\"%

call :srvinst zapret
goto :eof

:srvinst
net stop %1 >>logfile.log
sc delete %1 >>logfile.log
sc create %1 binPath= "\"%~dp0\bin\winws.exe\" %ARGS%" DisplayName= "FarewellDPI : %1" start= auto >>logfile.log
sc description %1 "FarewellDPI. Have fun in The Internet!" >>logfile.log
sc start %1 >>logfile.log