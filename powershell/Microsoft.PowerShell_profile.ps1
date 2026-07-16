# Microsoft.PowerShell_profile.ps1 — starter (Windows)

# Aliases
Set-Alias ll Get-ChildItem
function .. { Set-Location .. }

# Starship prompt (if installed)
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}

# Machine-specific, untracked overrides
$local = Join-Path $HOME ".powershell_profile.local.ps1"
if (Test-Path $local) { . $local }
