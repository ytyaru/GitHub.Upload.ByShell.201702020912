#!/bin/bash
# 動作環境
# * LinuxMint17.3MATE
# * SQLite3
# * jq
# 事前定義が必要な変数
# * USER_NAME
# * DB_REPO
function Aggregate()
{
	local COMMAND="sqlite3 ${DB_REPO}"
	local SQL="select count(*) RepoNum from Repositories;"
	local REPO_NUM=`echo $SQL | $COMMAND`
	echo "リポジトリ数: ${REPO_NUM}"

	local SQL="select min(CreatedAt) FirstDate from Repositories;"
	local FIRST_DATE=`echo $SQL | $COMMAND`
	echo "開始日: ${FIRST_DATE}"
	local SQL="select max(CreatedAt) LastDate from Repositories;"
	local LAST_DATE=`echo $SQL | $COMMAND`
	echo "終了日: ${LAST_DATE}"

	local FIRST_DATE_EPOC=`date -d"${FIRST_DATE}" +%s`
	local LAST_DATE_EPOC=`date -d"${LAST_DATE}" +%s`
	local DATE_SPAN=`expr \( ${LAST_DATE_EPOC} - ${FIRST_DATE_EPOC} \) / 60 / 60 / 24`
	echo "日数: ${DATE_SPAN} 日間"

	local AVG_REPO=`echo ${REPO_NUM} / ${DATE_SPAN} | awk '{print $1 / $3}'`
	echo "平均: ${AVG_REPO} repo/日"

	# 総Byte数
	local SQL="select SUM(Size) SumSize from Languages;"
	local SUM_SIZE=`echo $SQL | $COMMAND`
	echo "合計: ${SUM_SIZE} Byte"
	local AVG_SIZE=`echo ${SUM_SIZE} / ${DATE_SPAN} | awk '{print $1 / $3}'`
	echo "平均: ${AVG_SIZE} Byte"

	# 言語別Byte数
	local SQL="select Language,SUM(Size) SumSize from Languages group by Language order by SumSize desc;"
	echo $SQL | $COMMAND
}
Aggregate
