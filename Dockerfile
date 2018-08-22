FROM opensuse/leap

RUN zypper -n in jq lftp openssh

ADD assets/ /opt/resource/
RUN chmod +x /opt/resource/{check,in,out}
