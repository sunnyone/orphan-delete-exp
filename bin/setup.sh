#!/bin/bash

if [ -z "$2" ] ; then
  echo "usage: $0 mysql|postgres port"
  exit 1
fi

DBMS="$1"
PORT="$2"

if [ "$DBMS" != mysql -a "$DBMS" != postgres ] ; then
  echo "Invalid DBMS"
  exit 1
fi

cat sql/schema-$DBMS.sql | bin/connect-$DBMS.sh "$PORT"

CHILD_COUNT=1000
for I in `seq 1 100`; do
  PARENT_ID="$I"
  echo "Insert parent $PARENT_ID"
  sed -e "s|%ID%|$PARENT_ID|g" sql/parent.sql.in | bin/connect-$DBMS.sh "$PORT"

  for J in `seq 1 $CHILD_COUNT`; do
     CHILD_ID=$(($PARENT_ID * $CHILD_COUNT + $J))
     echo "Inserting child $CHILD_ID"
     sed -e "s|%ID%|$CHILD_ID|g" -e "s|%PARENT_ID%|$PARENT_ID|g" sql/child.sql.in | bin/connect-$DBMS.sh "$PORT"
     sed -e "s|%ID%|$CHILD_ID|g" -e "s|%CHILD_ID%|$CHILD_ID|g" -e "s|%PARENT_ID%|$PARENT_ID|g" sql/pointer.sql.in | bin/connect-$DBMS.sh "$PORT"
  done
done
