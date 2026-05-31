# Pull request — add Sovereign Wallet to WDK examples

Target repository: **https://github.com/tetherto/wdk-examples**

Prepared files live in: `contrib/wdk-examples-pr/`

## 1. Fork and clone

1. Open https://github.com/tetherto/wdk-examples
2. Click **Fork** → your account (`001453`)
3. Clone your fork:

```bash
git clone https://github.com/001453/wdk-examples.git
cd wdk-examples
git remote add upstream https://github.com/tetherto/wdk-examples.git
```

## 2. Copy the new example

From your Sovereign Wallet repo, copy the folder:

```
wdk-extension/contrib/wdk-examples-pr/browser-extension-sovereign-wallet/
  → wdk-examples/browser-extension-sovereign-wallet/
```

## 3. Update root README

In `wdk-examples/README.md`, add the table row from:

`wdk-extension/contrib/wdk-examples-pr/README-PATCH.md`

## 4. Commit and push

```bash
git checkout -b add-browser-extension-sovereign-wallet
git add browser-extension-sovereign-wallet README.md
git commit -m "Add browser extension starter index (Sovereign Wallet)"
git push origin add-browser-extension-sovereign-wallet
```

## 5. Open the PR

1. https://github.com/001453/wdk-examples/compare
2. Base: `tetherto/wdk-examples` → `main`
3. Compare: your branch `add-browser-extension-sovereign-wallet`

**Title:**

```
Add browser extension starter index (Sovereign Wallet)
```

**Body (copy/paste):**

```
## Summary

Adds a `browser-extension-sovereign-wallet/` entry to the examples index for the Browser Extension Starter reference implementation.

The full MV3 extension source is maintained at https://github.com/001453/Sovereign-wallet (build with `npm run build:prod`, load `dist/` in Chrome/Brave).

## What it covers

- WDK in a service worker (EVM, Bitcoin Blockbook, Solana)
- Encrypted vault, session lock, popup UX, `window.wdk` content provider
- Documentation and demo media in the main repo

## Note

This PR adds an index README only (no duplicated webpack bundle). The canonical repo stays the place to build and contribute code.

## License

Apache-2.0 — same as Sovereign Wallet.
```

## 6. After merge

Email or reply to Tether grant thread with the PR URL.

## Optional: GitHub CLI

```bash
gh auth login
gh pr create --repo tetherto/wdk-examples --base main --head 001453:add-browser-extension-sovereign-wallet --title "Add browser extension starter index (Sovereign Wallet)" --body-file pr-body.txt
```
