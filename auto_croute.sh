RULE_COUNT=$(ip rule | wc -l)

if [ $RULE_COUNT -lt 4 ]; then
  sh "$(dirname $(readlink -f $0))/croute.sh"
else
  echo Already pathed.
fi
