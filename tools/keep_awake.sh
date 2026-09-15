#!/system/bin/sh
# 临时阻止 PICO 头显休眠（固件刷写期间使用，防止传输被"未佩戴自动休眠"中断）
# 用法: sh keep_awake.sh [on|off|status]
case "$1" in
  on)
    setprop pvr.factorytest.never.sleep 1
    input keyevent 224 2>/dev/null
    echo "never.sleep=1（已尝试唤醒屏幕；刷写完成后请执行: sh $0 off）"
    ;;
  off)
    setprop pvr.factorytest.never.sleep 0
    echo "never.sleep=0（已恢复默认休眠策略）"
    ;;
  *)
    echo "never.sleep=$(getprop pvr.factorytest.never.sleep)  (1=保持常亮中, 0=默认)"
    ;;
esac
