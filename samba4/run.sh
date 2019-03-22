#!/bin/bash
set -e

N_ALUNOS=30

echo "nameserver $HOSTNAME" > /etc/resolv.conf

if [ ! -f "/usr/local/samba/etc/smb.conf" ]
then
	printf "\nProvisionando Samba4....\n\n"
	bin/samba-tool domain provision --server-role=dc --use-rfc2307 --dns-backend=SAMBA_INTERNAL --realm=AD.CAMPUS.IFRS.EDU.BR --domain=CAMPUS --adminpass=Passw0rd
	cp /usr/local/samba/private/krb5.conf /etc/
	printf "\nImportando...\n\n"
	bin/ldbadd -H private/sam.ldb 1-ou-users-groups.ldif
	printf "\n"
	bin/ldbmodify -H private/sam.ldb 2-member-groups.ldif
	printf "\nCriando usuários alunos, senha=senha5@\n\n"
	for i in $(seq 1 ${N_ALUNOS})
	do
	    bin/samba-tool user create aluno${i} senha5@ --given-name=Aluno${i} --surname=Sobrenome${i} --userou=OU=alunos --use-username-as-cn --mail-address=aluno${i}@campus.ifrs.edu.br
	done
fi
printf "\nIniciando Samba4...\n\n"
exec "$@"