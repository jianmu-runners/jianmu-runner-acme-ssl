#!/bin/bash

set -e

RESULT_SECRET=~/.acme.sh/${JIANMU_DOMAIN}/
OUTPUT_RESULT=${JM_SHARE_DIR}/.acme.sh

alias acme.sh=~/.acme.sh/acme.sh
# set default ca: letsencrypt
acme.sh --set-default-ca --server letsencrypt
# print acme.sh-version
acme.sh --version
# sitting email
acme.sh --register-account -m ${JIANMU_EMAIL}
# if DNS_CHECK=true
# Then acme.sh will wait for 10 seconds instead of checking through the public dns.
if test ${JIANMU_DNS_CHECK} = "true"
then
    echo "Wait 20s, acme.sh will use cloudflare public dns or google dns to check if the record has taken effect."
else
    DNS_CHECK_TIME="--dnssleep 10"
    echo "Then acme.sh will wait for 10 seconds instead of checking through the public dns."
fi
# Use WGET
if test ${JIANMU_WGET_USE} = "true"
then
    USE_WGET="--use-wget"
    echo "Use wget"
else
    echo "Use curl"
fi

echo dns_type: ${DNS_TYPE}
#choose your operator, aliyun huaweicloud or other operator
if test ${DNS_TYPE} = "dns_ali"
then
    # export Ali_Key and Ali_Secret
    export Ali_Key=${JIANMU_ALI_KEY}
    export Ali_Secret=${JIANMU_ALI_SECRET}
    echo "Use aliyun as operator"
elif test ${DNS_TYPE} = "dns_huaweicloud"
then
    # export huaweicloud configuration
    export HUAWEICLOUD_Username=${JIANMU_HUAWEICLOUD_USERNAME}
    export HUAWEICLOUD_Password=${JIANMU_HUAWEICLOUD_PASSWORD}
    export HUAWEICLOUD_ProjectID=${JIANMU_HUAWEICLOUD_PROJECT_ID}
    echo "Use huaweicloud as operator"
else
    echo "Please configure the correct operator"
fi


# get certificate
acme.sh --issue --dns ${DNS_TYPE} -d ${JIANMU_DOMAIN} ${DNS_CHECK_TIME} ${USE_WGET}

# generate output results
mkdir -p ${OUTPUT_RESULT}
cp ${RESULT_SECRET}/fullchain.cer ${OUTPUT_RESULT}
cp ${RESULT_SECRET}/${JIANMU_DOMAIN}.key ${OUTPUT_RESULT}
cd ${OUTPUT_RESULT}
ls -al
# echo result dir path
echo -e "{\n"\"cer_path\"" ":" "\"`pwd`/fullchain.cer\""","\n"\"key_path\"" ":" "\"`pwd`/${JIANMU_DOMAIN}.key\""\n"}"" > resultFile
mv resultFile /usr
cat /usr/resultFile