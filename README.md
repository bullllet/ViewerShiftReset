# ViewerShiftReset

An AutoHotkey v2 script for fixing Shift key bugs in Second Life viewers.  

This README contains both English and Japanese explanations.  
このREADMEには英語と日本語の説明が含まれています。

- [English](#readme-in-english)
- [Japanese](#readme-in-japanese)

---

## 📘 README in English

**Version**: 1.0.0  
**Author**: tsukasa.rexen

This AutoHotkey v2 script fixes the "stuck Shift key" bug in some Second Life viewers that can make chat input difficult or unintentionally trigger whisper mode.

---

### 🖥️ Requirements

- Windows 10/11
- AutoHotkey v2.0+

---

### 📦 How to Use

1. Make sure you have [AutoHotkey v2](https://www.autohotkey.com/) installed.
2. Download [ViewerShiftReset.ahk](https://raw.githubusercontent.com/tsukasa-rexen/ViewerShiftReset/main/ViewerShiftReset.ahk).
3. Run `ViewerShiftReset.ahk`.

---

### 🚀 Features

* ✅ Automatically releases Shift after short idle time
* ✅ Resets Shift before Enter key is sent
* ✅ Only active when a supported viewer app is in focus
* ✅ Lightweight and efficient (uses InputHook and timers)

Tested with: Firestorm, Alchemy, Black Dragon, and the official Second Life viewer.

---

### ⚙️ Configuration (inside the script)

```autohotkey
showPopup       := false ; Whether to display small popup windows on key detection or Shift Up action
typingThreshold := 200   ; Time (ms) after last keypress to consider idle and release Shift
checkActiveTime := 500   ; Interval (ms) to check if supported app is active
checkKeyTime    := 10    ; Interval (ms) to check for idle timeout after key input
```

Adjust these values depending on your viewer's responsiveness and system performance.

---

### 📄 License

This script is license-free. You are free to use, modify, and distribute it without restriction.

---

## 📙 README in Japanese

**バージョン**: 1.0.0  
**作者**: tsukasa.rexen

Second Lifeビューアで発生する「Shiftキー押しっぱなしバグ」により、チャット入力が困難になったり、意図せずささやきモードになる問題を修正するAutoHotkey v2スクリプトです。

---

### 🖥️ 動作環境

- Windows 10/11
- AutoHotkey v2.0 以降

---

### 📦  使い方

1. [AutoHotkey v2](https://www.autohotkey.com/) をインストール。
2. [ViewerShiftReset.ahk](https://raw.githubusercontent.com/tsukasa-rexen/ViewerShiftReset/main/ViewerShiftReset.ahk) をダウンロード。
3. `ViewerShiftReset.ahk` を実行。

---

### 🚀 特徴

* ✅ キー入力後、一定時間操作がないとShiftを自動的に解除
* ✅ Enterキー送信時にShift解除
* ✅ 対象アプリがアクティブなときのみ作動
* ✅ 軽量・高速動作（InputHookとタイマーを使用）

対応ビューア：Firestorm、Alchemy、Black Dragon、Second Life公式ビューア など

---

### ⚙️ スクリプト内の設定項目

```autohotkey
showPopup       := false ; キー入力やShift解除時にデバッグ用ポップアップを表示するか
typingThreshold := 200   ; 最後のキー入力からShift解除を行うまでの時間（ms）
checkActiveTime := 500   ; 対象アプリがアクティブかどうかの確認間隔（ms）
checkKeyTime    := 10    ; 無操作状態の監視間隔（ms）
```

環境に応じて適宜変更してください。

---

### 📄 ライセンス

このスクリプトはライセンスフリーです。ご自由にお使いください。
