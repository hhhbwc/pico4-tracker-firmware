#!/system/bin/sh
# 查看追踪器固件状态与升级检查
echo "== never.sleep = $(getprop pvr.factorytest.never.sleep) （刷写期间建议为 1） =="
echo "== checkupgrade =="
tracker_test checkupgrade 2>&1 | tail -3
echo "== 最近追踪器状态（softwareVer / online） =="
logcat -d -t 5000 2>/dev/null | grep -E "tracker[123], online [01] .*softwareVer" | tail -6
echo "== 服务日志补充（若上面为空） =="
F=$(ls -t /data/misc/pxr/tracking/swift/MCUTracker.2*.log 2>/dev/null | head -1)
if [ -n "$F" ]; then
  grep -E "softwareVer" "$F" | tail -6
fi
