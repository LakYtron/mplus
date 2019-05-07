#!/bin/bash

DIR="/var/app"

#echo $DIR | sed 's/\\/\/\\/g'

#echo $DIRTR

FILES="
/srv/log/deva/caseg2/case/application/*.log 
/srv/log/deva/caseg2/casecore/application/case.log 
/opt/jboss-eap-7.0/domain/servers/auth/log/server.log 
/opt/jboss-eap-7.0/domain/servers/sts/log/server.log 
/opt/jboss-eap-7.0/domain/servers/case/log/server.log 
/opt/jboss-eap-7.0/domain/servers/config/log/server.log"


GREP1="Client verification is disabled"
GREP2="NameNotFoundException"
GREP3="getEncryptedProperty"
GREP4="FTA_XML_SIGNATURE_BUILDER"
GREP5="errors.MepException"
GREP6="but should have been encrypted"

#tail -f `find /var/app -type f -name "*.log"` | awk '/\/var\/app\// {print "\033[32m" $0 "\033[39m"} /WARN/ {print "\033[33m" $0 "\033[39m"} /ERROR / {print "\033[31m" $0 "\033[39m"} / Exception:/ {print "\033[31m" $0 "\033[39m"}'

#tail -f $FILES | awk ' /log <==/ {print "\033[32m" $0 "\033[39m"} /WARN/ {print "\033[33m" $0 "\033[39m"} /ERROR / {print "\033[31m" $0 "\033[39m"} / Exception:/ {print "\033[31m" $0 "\033[39m"}'
tail -f $FILES | grep -Fv -e "$GREP1" -e "$GREP2" -e "$GREP3" -e "$GREP4" -e "$GREP5" -e "$GREP6" | awk ' /log <==/ {print "\033[32m" $0 "\033[39m"} /WARN/ {print "\033[33m" $0 "\033[39m"} /ERROR / {print "\033[31m" $0 "\033[39m"} /Exception:/ {print "\033[31m" $0 "\033[39m"}'
#tail -f $FILES | grep -Fv -e "$GREP1" -e "$GREP2" | awk ' /WARN/ {print "\033[33m" $0 "\033[39m"} /ERROR / {print "\033[31m" $0 "\033[39m"} /Exception:/ {print "\033[31m" $0 "\033[39m"} /log <==/ {print "\033[32m" $0 "\033[39m"}'

echo;



