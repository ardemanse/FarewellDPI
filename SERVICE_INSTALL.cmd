chcp 65001
pushd "%~dp0"
del /F /Q logfile.log

:: -=-=-=-=-=-=-=-=-=-=-= Edit strategies here -=-=-=-=-=-=-=-=-=-=-= ::
set BLACKLIST80=--dpi-desync=fake,multisplit --dpi-desync-fake-http="%~dp0fake\http_iana_org.bin" --dpi-desync-split-seqovl=5 --dpi-desync-split-pos=7,method+2,host+4,-32 --dpi-desync-fooling=md5sig,badseq --dpi-desync-repeats=4

set BLACKLIST443=--dpi-desync=fake,multisplit --dpi-desync-fake-tls="%~dp0fake\tls_clienthello_vk_com.bin" --dpi-desync-split-seqovl=458 --dpi-desync-split-seqovl-pattern="%~dp0fake\tls_clienthello_mail_ru.bin" --dpi-desync-split-pos=sld-5,sld,midsld-1,midsld+1,endsld,sniext,sniext+16,host+2,host+7,-52,-42 --dpi-desync-fooling=md5sig,badseq --dpi-desync-autottl=1 --dpi-desync-autottl6=1 --dpi-desync-repeats=6

set AUTO443=--dpi-desync=fake,multisplit --dpi-desync-fake-tls="%~dp0fake\tls_clienthello_mail_ru.bin" --dpi-desync-split-seqovl=398 --dpi-desync-split-seqovl-pattern="%~dp0fake\tls_clienthello_vk_com.bin" --dpi-desync-split-pos=sld-2,midsld,endsld+1,sniext+7,host+1,endhost --dpi-desync-fooling=md5sig,badseq --dpi-desync-autottl=1 --dpi-desync-autottl6=1 --dpi-desync-repeats=3

set YT443=--dpi-desync=fake,fakedsplit --dpi-desync-fake-tls="%~dp0fake\tls_clienthello_mail_google_com.bin" --dpi-desync-split-seqovl=456 --dpi-desync-split-seqovl-pattern="%~dp0fake\tls_clienthello_www_google_com.bin" --dpi-desync-split-pos=midsld-1 --dpi-desync-fooling=md5sig,datanoack --dpi-desync-repeats=8

set QUIC443=--dpi-desync=fake,ipfrag2 --dpi-desync-fake-quic="%~dp0fake\quic_initial_vk_com.bin" --dpi-desync-ipfrag-pos-udp=32 --dpi-desync-repeats=12

set DISQ50000=--dpi-desync=fake,udplen --dpi-desync-fake-unknown-udp="%~dp0fake\quic_short_header.bin" --dpi-desync-udplen-increment=8 --dpi-desync-udplen-pattern=0xDEADBEEF --dpi-desync-cutoff=d2 --dpi-desync-any-protocol --dpi-desync-repeats=4
:: -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= ::

set ARGS=--wf-tcp=80,443 --wf-udp=443,50000-50099 --filter-tcp=80 --hostlist="%~dp0lists\blacklist.txt" --hostlist-exclude="%~dp0lists\exclude.txt" --hostlist="%~dp0lists\customhostlist.txt" %BLACKLIST80% --new --filter-tcp=443 --hostlist="%~dp0lists\blacklist.txt" --hostlist-exclude="%~dp0lists\exclude.txt" --hostlist="%~dp0lists\customhostlist.txt" --hostlist="%~dp0lists\discord.txt" %BLACKLIST443% --new --filter-tcp=443 --hostlist-auto="%~dp0lists\autohostlist.txt" --hostlist-exclude="%~dp0lists\exclude.txt" %AUTO443% --new --filter-tcp=443 --hostlist="%~dp0lists\youtube.txt" %YT443% --new --filter-udp=443 %QUIC443% --new --filter-udp=50000-50099 %DISQ50000%
set ARGS=%ARGS:"=\"%

call :srvinst zapret
goto :eof

:srvinst
net stop %1 >>logfile.log
sc delete %1 >>logfile.log
sc create %1 binPath= "\"%~dp0\bin\winws.exe\" %ARGS%" DisplayName= "FarewellDPI : %1" start= auto >>logfile.log
sc description %1 "FarewellDPI. Have fun in The Internet!" >>logfile.log
sc start %1 >>logfile.log