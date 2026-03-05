# Justfile for running PowerShell scripts in the repo

# Usage: just <recipe>

# Run autosave script
autosave:
    pwsh -File scripts/autosave.ps1

# Run backup script
backup:
    pwsh -File scripts/backup.ps1

# Run brain script
brain:
    pwsh -File scripts/brain.ps1

# Run encrypt script
encrypt:
    pwsh -File scripts/encrypt.ps1

# Run generate-hub-index script
hub-index:
    pwsh -File scripts/generate-hub-index.ps1

# Run git-setup script
setup-git:
    pwsh -File scripts/git-setup.ps1

# Run init-pwr-brain script
init:
    pwsh -File scripts/init-pwr-brain.ps1

# Run update-menu script
update-menu:
    pwsh -File scripts/update-menu.ps1
