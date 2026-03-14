# OllaCommit

**OllaCommit** is a lightweight macOS Quick Action that leverages local AI (**Ollama + qwen2.5:0.5b**) to transform your messy notes into professional, English Git Commit messages following the **Conventional Commits** standard.

---

### ✨ Features

* **100% Local & Private**: No data leaves your machine. Powered by Ollama.
* **Near-Instant**: Optimized for the `qwen2.5:0.5b` model for ultra-fast inference.
* **English Output**: Automatically translates and formats input to English.
* **Smart Mapping**: Intelligently categorizes UI, Layout, and Visual changes as `style`.
* **Auto-Formatting**: Ensures the description starts with a lowercase letter and stays under 50 characters.

---

### 📦 Project Structure

```text
OllaCommit/
├── README.md
├── LICENSE
└── scripts/
    └── commit_gen.sh    # The core logic (Python embedded in Zsh)
```

---

### 🛠️ Prerequisites

1. **Ollama**: [Download here](https://ollama.com).
2. **Model**: Pull the lightweight Qwen model:
```bash
ollama pull qwen2.5:0.5b
```


3. **Python 3**: Ensure it's available on your system (usually pre-installed on macOS).

---

### 🚀 Installation

#### 1. Clone the Repository

Clone this project to a stable location on your Mac:

```bash
git clone https://github.com/hearsilent/OllaCommit.git
cd OllaCommit
chmod +x scripts/commit_gen.sh
```

#### 2. Create macOS Quick Action

1. Open **Automator**.
2. Select **New Document** -> **Quick Action**.
3. Set the following at the top:
* Workflow receives current: **text**
* in: **any application**
* Check: **Output replaces selected text**


4. Add a **"Run Shell Script"** action.
5. Set **Shell** to `/bin/zsh` and **Pass input** to **as arguments**.

**Now choose one of the following options:**

##### Option A: Link to the script file (Best for easy updates)

If you cloned the repo, paste this bridge command (replace the path with your actual location):

```zsh
zsh "$HOME/path/to/OllaCommit/scripts/commit_gen.sh" "$1"
```

##### Option B: Paste the full script directly (Quickest setup)

If you don't want to keep the repository folder, you can copy the entire content of `scripts/commit_gen.sh` from this repo and paste it directly into the Automator box.

#### 3. Save

Save the action as **"Git Commit Generator"**.

---

### ⌨️ Set a Keyboard Shortcut (Recommended)

1. Go to **System Settings** -> **Keyboard** -> **Keyboard Shortcuts**.
2. Select **Services** -> **Text**.
3. Find **Git Commit Generator** and assign a shortcut (e.g., `Control + Option + G`).

---

### 📖 Usage Examples

| Input (Highlight) | Output (Replaced) |
| --- | --- |
| `新增首頁 Banner` | `feat: add home banner` |
| `調整按鈕間距` | `style: adjust button spacing` |
| `Fix login crash` | `fix: resolve login crash` |
| `優化資料庫查詢` | `perf: optimize database query` |

1. **Highlight** any text (Chinese or English).
2. Press your **Shortcut** (or use the Right-click -> Services menu).
3. The AI will instantly replace the text with a formatted commit message.

> **Note**: If the text doesn't change, ensure the **Ollama app** is running.

---

### 💡 Why use a script file?

By linking to `scripts/commit_gen.sh` (Option A), you can update the prompt logic or switch models via `git pull` without ever having to re-open Automator.

---

### 📄 License

This project is licensed under the **MIT License**.