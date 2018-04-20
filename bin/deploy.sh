#!/bin/bash

# 変数
REMOTE_HOST_STG=test-fileup01
REMOTE_HOST_PRD=fileup01
REMOTE_PATH=/home/www/kyoto365/docroot/
LOCAL_PATH=${WORKSPACE}/dist/
BACKUP_PATH=${WORKSPACE}/_backup/

if [ "${TARGET}" = "stg" ] ; then
  REMOTE_HOST=$REMOTE_HOST_STG
elif [ "${TARGET}" = "prd" ] ; then
  REMOTE_HOST=$REMOTE_HOST_PRD
else
  echo -e "\n\n*** REMOTE_HOSTが設定できませんでした ***"
  exit
fi

# コマンド
RSYNC="rsync -rlcv --delete"
RSYNC_BACKUP="rsync -rl"

# デプロイ
if ${DRYRUN} ; then
  echo -e "\n\n*** dryrun : ${REMOTE_HOST} ***"
  $RSYNC -n --exclude '.git/' $LOCAL_PATH $REMOTE_HOST:$REMOTE_PATH
else
  if [ "${TARGET}" = "prd" ] ; then

    # failbackジョブのWSの過去の本番バックアップを削除
    if test -d $BACKUP_PATH ; then
      rm -rf $BACKUP_PATH
    fi

    # failbackジョブのWSに本番バックアップを作成
    echo -e "\n\n*** backup ***"
    $RSYNC_BACKUP $REMOTE_HOST:$REMOTE_PATH $BACKUP_PATH
    echo -e "\n\n*** backup done ***"
  fi

  echo -e "\n\n*** deploy : ${REMOTE_HOST} ***"
  $RSYNC --exclude '.git/' $LOCAL_PATH $REMOTE_HOST:$REMOTE_PATH
  echo -e "\n\n*** deploy done ***"
fi
