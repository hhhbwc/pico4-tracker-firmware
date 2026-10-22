> 🧪 **Real-world test**: there is no difference whatsoever between the two firmware versions — at least I couldn't feel one. Honestly, this project seems pretty useless XD.

🌐 [简体中文](README.md) | English | [Русский](README_RU.md)

# PICO Motion Tracker Firmware Toolkit (update / downgrade)

> ⚠️ Unofficial project, for learning and research only. The firmware is copyright PICO; you flash at your own risk.

Tools and guides for **updating / downgrading** the firmware of the **PICO Motion Tracker** on PICO 4.
Built around the `tracker_test` utility that already ships with the system; **two-way flashing — both upgrade and downgrade — verified on a real device**.

## ✅ Verified results (PICO 4 A8110 + 3 trackers, 2026-09)

| Direction | Result |
|---|---|
| Upgrade | ✅ TR0189 (sv1.89) → **TR0191 (sv1.91)**, all three trackers succeeded |
| Downgrade | ✅ TR0191 → TR0189 works in practice (**can be reflashed back**, nothing blocks either direction) |
| Duration | about 3–4 minutes per full set; the trackers briefly drop offline / reboot while flashing (normal) |

## What this is

The system's own `tracker_test` tool can flash firmware onto already-paired trackers:

```bash
tracker_test UpdateTracker <1|2|3> /path/to/Swift2.0_sv1.XX_....bin
```

This repository provides:

- **Verified firmware images** (`firmware/`): sv1.89 (shipped with PICO 4) / sv1.91 (the generation used by PICO 4 Ultra)
- **Helper scripts** (`tools/`): flashing with logging, keep-awake toggle, status check
- **On-device test records** (`docs/`)

## Usage

### Requirements

- Root (Magisk) — needed to run the built-in system tool
- Trackers online (they connect as soon as the headset screen is on) and sufficiently charged
- **Keep the headset screen on and awake** — this is the critical one; auto-sleep when the headset is not worn interrupts the transfer

### Steps

```bash
# 0. Push firmware and scripts to the device
adb push firmware/Swift2.0_sv1.91_20250827_b191_app.bin /data/local/tmp/
adb push tools/*.sh /data/local/tmp/

# 1. Stop the headset from sleeping (turn it back off once flashing is done)
adb shell su -c "sh /data/local/tmp/keep_awake.sh on"

# 2. Flash (this walks through the whole tracker group and takes a few minutes)
adb shell su -c "sh /data/local/tmp/update_tracker.sh 1 /data/local/tmp/Swift2.0_sv1.91_20250827_b191_app.bin"

# 3. Verify (after the trackers have come back up)
adb shell su -c "sh /data/local/tmp/check.sh"

# 4. Restore the normal sleep policy
adb shell su -c "sh /data/local/tmp/keep_awake.sh off"
```

### Downgrade (rollback)

Run the same command with `firmware/Swift2.0_sv1.89_20241213_b189_app.bin` instead (tested).

## FAQ

- **The transfer was interrupted?** Just re-run the same command — it reflashes, and in my testing everything was fine afterwards.
- **Can this brick a tracker?** The image is signature-verified; an interruption only costs you a retry, it cannot damage the hardware.
- **Trackers disappeared after flashing?** They are rebooting and come back within 1–2 minutes (`check.sh` shows their state).
- **Where the firmware comes from**: sv1.89 is the copy shipped in the PICO 4 system at `/system/etc/trackerbin/`; sv1.91 was extracted from a PICO 4 Ultra system component package.
- **Note**: the official P4 channel still ships sv1.89, and 1.91 belongs to the Ultra generation. If you want to go back after upgrading, use the downgrade steps above.

## Disclaimer

For learning and research only; the firmware and the system tool are copyright PICO; you flash at your own risk.
