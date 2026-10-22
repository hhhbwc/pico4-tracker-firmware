> 🧪 **实测**：两个版本之间没有任何差异，最起码我体感是这样子的，感觉这个项目没啥用 XD。

🌐 [简体中文](README.md) | [English](README_EN.md) | [Русский](README_RU.md)

# PICO 体感追踪器 固件工具（升级 / 降级）

> ⚠️ 非官方项目，仅供学习研究。固件版权归 PICO 所有，操作风险自负。

在 PICO 4 上对 **PICO 体感追踪器（Motion Tracker）** 进行固件**升级 / 降级**的工具与指南。
基于系统自带官方工具 `tracker_test`，已在真机完整验证 **双向刷写（升级 + 降级均可）**。

## ✅ 已验证结论（PICO 4 A8110 + 3 台追踪器，2026-09）

| 方向 | 结果 |
|---|---|
| 升级 | ✅ TR0189（sv1.89）→ **TR0191（sv1.91）**，三台全部成功 |
| 降级 | ✅ TR0191 → TR0189 实测可行（**可以刷回**，双向无阻碍） |
| 耗时 | 约 3–4 分钟/整套；刷写时追踪器短暂离线/重启（正常） |

## 这是什么

系统自带官方工具 `tracker_test` 支持对已配对的追踪器刷写固件：

```bash
tracker_test UpdateTracker <1|2|3> /path/to/Swift2.0_sv1.XX_....bin
```

本仓库提供：

- **已验证固件包**（`firmware/`）：sv1.89（P4 官方自带）/ sv1.91（PICO 4 Ultra 同代）
- **辅助脚本**（`tools/`）：刷写（带日志）、防休眠开关、状态检查
- **实机测试记录**（`docs/`）

## 使用方法

### 前置要求

- Root（Magisk）——需要运行系统内置工具
- 追踪器在线（头显亮屏即可连接）、电量充足
- **头显保持亮屏/活跃**（关键！未佩戴自动休眠会中断传输）

### 步骤

```bash
# 0. 推送固件与脚本到设备
adb push firmware/Swift2.0_sv1.91_20250827_b191_app.bin /data/local/tmp/
adb push tools/*.sh /data/local/tmp/

# 1. 防止头显休眠（刷写完成后记得 off）
adb shell su -c "sh /data/local/tmp/keep_awake.sh on"

# 2. 刷写（该命令会依次处理整个追踪器组，需要几分钟）
adb shell su -c "sh /data/local/tmp/update_tracker.sh 1 /data/local/tmp/Swift2.0_sv1.91_20250827_b191_app.bin"

# 3. 验证（等追踪器重启回来后）
adb shell su -c "sh /data/local/tmp/check.sh"

# 4. 恢复休眠策略
adb shell su -c "sh /data/local/tmp/keep_awake.sh off"
```

### 降级（回滚）

用同样的命令刷 `firmware/Swift2.0_sv1.89_20241213_b189_app.bin` 即可（已实测）。

## 常见问题

- **传输中断了怎么办？** 直接重新执行同一命令（会重刷；实测中断后重刷一切正常）
- **会不会变砖？** 固件镜像有签名校验；中断只会导致重试，不会损坏硬件
- **刷完追踪器不见了？** 它在重启，1–2 分钟后回来（`check.sh` 可看状态）
- **固件来源**：sv1.89 = PICO 4 系统自带 `/system/etc/trackerbin/`；sv1.91 提取自 PICO 4 Ultra 系统组件包
- **注意**：P4 官方线目前仍带 sv1.89，1.91 属 Ultra 同代；升级后如需回退按上面"降级"即可

## 免责声明

仅供学习研究；固件与系统工具版权归 PICO 所有；操作风险自负。
