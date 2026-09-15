# v1.0 — Firmware packages + tools (initial release)

🇬🇧 English below · 🇷🇺 Русский ниже · 🇨🇳 中文最下方

---

## 🇬🇧 English

Unofficial toolkit for updating / downgrading **PICO Motion Tracker** firmware on **PICO 4**,
built around the stock `tracker_test` utility.

**Verified on a real device: upgrade (TR0189 → TR0191) and DOWNGRADE both work.**

Contents:

- `firmware/Swift2.0_sv1.89_20241213_b189_app.bin` — stock P4 firmware (sv1.89)
- `firmware/Swift2.0_sv1.91_20250827_b191_app.bin` — PICO 4 Ultra-era firmware (sv1.91)
- `tools/` — update / keep-awake / check scripts

⚠️ Keep the headset awake during flashing (use `tools/keep_awake.sh`).
See `README.md` and `docs/` for full instructions and the test log.

---

## 🇷🇺 Русский

Неофициальный набор для обновления / отката прошивки **PICO Motion Tracker** на **PICO 4**
(на базе штатной утилиты `tracker_test`).

**Проверено на реальном устройстве: обновление (TR0189 → TR0191) и ОТКАТ работают.**

Содержимое:

- `firmware/Swift2.0_sv1.89_20241213_b189_app.bin` — стоковая прошивка P4 (sv1.89)
- `firmware/Swift2.0_sv1.91_20250827_b191_app.bin` — прошивка эпохи PICO 4 Ultra (sv1.91)
- `tools/` — скрипты обновления / защиты от сна / проверки

⚠️ Во время прошивки шлем должен оставаться активным (`tools/keep_awake.sh`).
Инструкции и журнал тестов — в `README.md` и `docs/`.

---

## 🇨🇳 中文

体感追踪器固件升级/降级工具（初版，PICO 4 真机验证）：

- **升级**：TR0189 → TR0191 三台全部成功
- **降级**：TR0191 → TR0189 实测可行（双向刷写无阻）
- 包含：sv1.89 / sv1.91 固件包、刷写/防休眠/检查脚本、实机测试记录

⚠️ 刷写期间保持头显亮屏活跃（用 `tools/keep_awake.sh`）。
使用方法见 `README.md` 与 `docs/`。

---

For learning & research only. Firmware © PICO.
