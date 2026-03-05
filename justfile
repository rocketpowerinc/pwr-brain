
# Justfile for running PowerShell scripts in the repo

set shell := ["pwsh", "-c"]

# Usage: just <recipe>

autosave:
    scripts/autosave.ps1

backup:
    scripts/backup.ps1

brain:
    scripts/brain.ps1

encrypt:
    scripts/encrypt.ps1

hub-index:
    scripts/generate-hub-index.ps1

setup-git:
    scripts/git-setup.ps1

init:
    scripts/init-pwr-brain.ps1

update-menu:
    scripts/update-menu.ps1
