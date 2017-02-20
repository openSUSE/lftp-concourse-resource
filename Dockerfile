FROM opensuse:42.2

RUN zypper -n in jq lftp

ADD assets/ /opt/resource/
RUN chmod +x /opt/resource/{check,in,out}
