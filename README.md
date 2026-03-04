# pwr-brain

A cross-platform, Markdown-based Personal Knowledge Management (PKM) system powered by PowerShell (pwsh).

## Features

- **Simple Markdown notes**: Organize your knowledge in plain text files.
- **Portable**: Works on Windows, macOS, and Linux with PowerShell Core.
- **Encryption**: Secure your notes with AES encryption before backup.
- **Automated Backups**: Upload encrypted backups to Google Drive using rclone.
- **Git Integration**: Autosave and version your notes with Git.
- **Easy Initialization**: Clone the repo anywhere and run a single script to set up a new brain.

## Directory Structure

```
pwr-brain/
├── menu.md                # Main menu/index
├── hubs/                  # Topic hubs (Markdown folders)
│   └── example/
│       └── example.md
├── scripts/               # PowerShell automation scripts
│   ├── brain.ps1          # Main menu script
│   ├── git-setup.ps1      # Git initialization
│   ├── autosave.ps1       # Autosave/commit changes
│   ├── encrypt.ps1        # Encrypt notes
│   ├── backup.ps1         # Encrypt + backup to Google Drive
│   └── init-pwr-brain.ps1 # Initialize a new brain anywhere
├── backups/               # Encrypted backup files
├── .gitignore             # Ignore sensitive files
└── README.md
```

## Getting Started

### 1. Prerequisites

- [PowerShell 7+ (pwsh)](https://aka.ms/powershell)
- [Git](https://git-scm.com/)
- [rclone](https://rclone.org/) (for Google Drive backup)

### 2. Clone and Initialize

```sh
git clone https://github.com/yourusername/pwr-brain.git
cd pwr-brain
pwsh scripts/init-pwr-brain.ps1  # Sets up a new brain in the current directory
```

### 3. Configure rclone for Google Drive

Follow the [rclone Google Drive setup guide](https://rclone.org/drive/) and name your remote `gdrive`.

### 4. Using the System

- Run the main menu:
  ```sh
  pwsh scripts/brain.ps1
  ```
- Choose options to autosave, encrypt, or backup your notes.

### 5. Adding Notes

- Add Markdown files under `hubs/` or create new topic folders.

## Security

- Encryption uses AES; password is never stored.
- `.gitignore` ensures backups and sensitive files are not committed.

## Portability

- All scripts use cross-platform PowerShell and relative paths.
- To start a new brain anywhere, copy the repo and run `scripts/init-pwr-brain.ps1`.

## License

MIT

---

> Built for privacy, simplicity, and total control over your knowledge.
