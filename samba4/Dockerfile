FROM debian:stretch

ENV DEBIAN_FRONTEND=noninteractive
ENV SMBVERSION=4.9.5

EXPOSE 389 636

RUN apt-get update -yqq \
    && apt-get install -yqq acl attr autoconf bind9utils bison build-essential \
         debhelper dnsutils docbook-xml docbook-xsl flex gdb libjansson-dev krb5-user \
         libacl1-dev libaio-dev libarchive-dev libattr1-dev libblkid-dev libbsd-dev \
         libcap-dev libcups2-dev libgnutls28-dev libgpgme-dev libjson-perl \
         libldap2-dev libncurses5-dev libpam0g-dev libparse-yapp-perl \
         libpopt-dev libreadline-dev nettle-dev perl perl-modules pkg-config \
         python-all-dev python-crypto python-dbg python-dev python-dnspython \
         python3-dnspython python-gpgme python3-gpgme python-markdown python3-markdown \
         python3-dev xsltproc zlib1g-dev liblmdb-dev lmdb-utils wget \
         rng-tools  python-ldap python-gpgme vim nano \
    && wget https://download.samba.org/pub/samba/stable/samba-${SMBVERSION}.tar.gz -O /tmp/samba-${SMBVERSION}.tar.gz \
	&& tar zxf /tmp/samba-${SMBVERSION}.tar.gz -C /tmp \
	&& cd /tmp/samba-${SMBVERSION} \
	&& ./configure \
	&& make \
	&& make install \
	&& apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    && rm -rf /tmp/*


WORKDIR /usr/local/samba/

VOLUME /usr/local/samba/

COPY ./run.sh .
COPY ./1-ou-users-groups.ldif .
COPY ./2-member-groups.ldif .

RUN chmod 777 ./run.sh

ENTRYPOINT ["./run.sh"]
CMD ["/usr/local/samba/sbin/samba", "-F","-d4"]