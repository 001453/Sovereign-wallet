# Sovereign Wallet — reset GitHub Contributors (remove stale cursoragent).
# GitHub keeps orphaned commits with "Co-authored-by: Cursor" even after force-push.
# The repo sidebar only clears after DELETE + recreate (new repository id).
#
# Usage:
#   1. Run this script (it checks local history and squashes to one commit).
#   2. Follow the printed steps to delete the repo on GitHub.
#   3. Create an empty repo with the SAME name, then press Enter here to push.

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $RepoRoot

function Test-NoCoAuthorTrailers {
    $bad = @()
    foreach ($rev in (git rev-list --all)) {
        $body = git log -1 --format=%B $rev
        if ($body -match '(?i)Co-authored-by:.*cursor|cursoragent|Made-with:\s*Cursor') {
            $bad += $rev
        }
    }
    return $bad
}

Write-Host "=== Local co-author scan ===" -ForegroundColor Cyan
$bad = Test-NoCoAuthorTrailers
if ($bad.Count -gt 0) {
    Write-Host "FAIL: co-author trailers found in:" -ForegroundColor Red
    $bad | ForEach-Object { git log -1 --oneline $_ }
    exit 1
}
Write-Host "OK: no Cursor co-author in local history." -ForegroundColor Green

Write-Host "`n=== Enable commit hook (this repo) ===" -ForegroundColor Cyan
git config core.hooksPath .githooks
Write-Host "core.hooksPath = .githooks"

$count = (git rev-list --count HEAD)
if ($count -gt 1) {
    Write-Host "`nSquashing $count commits into one..."
    $root = git rev-list --max-parents=0 HEAD
    git reset --soft $root
    git commit --amend -m "Sovereign Wallet — multi-chain MV3 extension with non-custodial OTC escrow"
}
Write-Host "HEAD: $(git log -1 --oneline)"

Write-Host @"

=== DELETE repo on GitHub (required) ===
1. Open: https://github.com/001453/Sovereign-wallet/settings
2. Danger Zone -> Delete this repository
3. Type: 001453/Sovereign-wallet

=== CREATE empty repo (same name) ===
1. https://github.com/new
2. Name: Sovereign-wallet
3. Do NOT add README, .gitignore, or license (empty repo)

=== Cursor (prevent future co-author) ===
Settings already should have:
  cursor.agent.commitAttribution = false
  cursor.agent.prAttribution = false

"@ -ForegroundColor Yellow

$null = Read-Host "Press Enter after the new empty repo exists on GitHub"

Write-Host "Pushing main..."
git remote get-url origin | Out-Null
git push -u origin main --force
if ($LASTEXITCODE -ne 0) {
    Write-Host "Push failed. Check remote URL and that the empty repo exists." -ForegroundColor Red
    exit $LASTEXITCODE
}

Write-Host @"

Done. Verify:
  https://github.com/001453/Sovereign-wallet
  Contributors should show only @001453 (may take a few minutes).

Old commit URLs (e.g. /commit/38d070b) will 404 after delete.

"@ -ForegroundColor Green
