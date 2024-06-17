#!/bin/bash

COLOR=$(tput setaf 2)
NC=$(tput sgr0)

clear

date


ssh root@172.26.0.72 -C "qm start 9196" 2> >(grep -v "Permanently added" 1>&2)
printf "\n%s\n"  "${COLOR}Server diba-minio.ilba.cat is back online${NC}"
echo ""

ssh root@172.26.0.71 -C "qm start 9195" 2> >(grep -v "Permanently added" 1>&2)
printf "\n%s\n"  "${COLOR}Server diba-nfs.ilba.cat is back online${NC}"
echo ""

printf "%s" "${COLOR}Waiting for diba-minio.ilba.cat ...${NC}"
while ! ping -c 1 -n -w 1 172.26.0.196 &> /dev/null
do
    printf "%c" "${COLOR}.${NC}"
done
echo ""
printf "\n%s\n"  "${COLOR}Server diba-minio.ilba.cat is back online${NC}"



ssh root@172.26.0.72 -C "qm start 9239" 2> >(grep -v "Permanently added" 1>&2)
printf "\n%s\n"  "${COLOR}Server ceph-aio.ilba.cat is back online${NC}"
echo ""

printf "%s" "${COLOR}Waiting for ceph-aio.ilba.cat ...${NC}"
while ! ping -c 1 -n -w 1 172.26.0.239 &> /dev/null
do
    printf "%c" "${COLOR}.${NC}"
done
echo ""
printf "\n%s\n"  "${COLOR}Server ceph-aio.ilba.cat is back online${NC}"

# 4 minutos
sleep 240

ssh root@172.26.0.71 -C "qm start 9191" 2> >(grep -v "Permanently added" 1>&2)
printf "\n%s\n"  "${COLOR}Server diba-master.ilba.cat is back online${NC}"
echo ""

ssh root@172.26.0.71 -C "qm start 9192" 2> >(grep -v "Permanently added" 1>&2)
printf "\n%s\n"  "${COLOR}Server diba-master-1.ilba.cat is back online${NC}"
echo ""

ssh root@172.26.0.72 -C "qm start 9193" 2> >(grep -v "Permanently added" 1>&2)
printf "\n%s\n"  "${COLOR}Server diba-master-2.ilba.cat is back online${NC}"
echo ""

ssh root@172.26.0.72 -C "qm start 9194" 2> >(grep -v "Permanently added" 1>&2)
printf "\n%s\n"  "${COLOR}Server diba-master-3.ilba.cat is back online${NC}"
echo ""


date

echo ""
printf "Conectate al equipo: \033[0;33mssh 172.26.0.191\033[0m\n"
echo ""

