#!/system/bin/sh
# PICO 体感追踪器固件刷写（升级/降级通用）
# 用法: sh update_tracker.sh <tracker_id:1|2|3> <firmware.bin>
ID="$1"
BIN="$2"
if [ -z "$ID" ] || [ ! -f "$BIN" ]; then
  echo "usage: sh $0 <1|2|3> <firmware.bin>"
  echo "(建议先执行: sh keep_awake.sh on，保持头显亮屏)"
  exit 1
fi
D=/sdcard/tracker_fw
mkdir -p "$D"
LOG="$D/update_$(date +%Y%m%d_%H%M%S).log"
AW=$(getprop pvr.factorytest.never.sleep)
echo "== 刷写 tracker $ID <- $BIN =="
echo "== never.sleep=$AW （建议为 1，见 keep_awake.sh） =="
echo "== 请保持头显亮屏/活跃，勿让追踪器静止入睡 =="
tracker_test UpdateTracker "$ID" "$BIN" 2>&1 | tee "$LOG"
echo "== 刷写流程结束；日志: $LOG =="
sleep 8
echo "== checkupgrade =="
tracker_test checkupgrade 2>&1 | tail -2
echo "== 最近追踪器状态 =="
logcat -d -t 3000 2>/dev/null | grep -E "tracker[123], online [01] .*softwareVer" | tail -6
