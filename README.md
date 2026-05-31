# Sovereign Wallet

Self-custodial Chrome extension wallet built with [Tether WDK](https://wdk.tether.io): Manifest V3 service worker for keys and signing, popup UI, and a content-script `window.wdk` provider for dApps.

**Chains:** Ethereum, Polygon, Arbitrum, BNB Smart Chain (EVM), Bitcoin (Blockbook), Solana.

**Escrow (OTC):** Non-custodial USDT ↔ any ERC-20/BEP-20 on EVM — see [docs/ESCROW.md](docs/ESCROW.md). BSC mainnet factory is configured in `public/escrow.json`; deploy steps stay in the docs (not in the wallet UI).

## Build

```bash
npm install
npm run build:prod
```

Load `dist/` from `chrome://extensions` (Developer mode → Load unpacked). Use `npm run dev` for a watched build.

## Demo

- **Demo video:** [docs/demo/](docs/demo/) — open `index.html` locally after clone, or download the MP4
- **Screenshots:** [docs/screenshots/](docs/screenshots/)

## Repo map

| Path | |
|------|---|
| `src/background/` | vault, session, WDK |
| `src/config/chains.js` | RPC + token addresses |
| `public/popup.html` | UI markup |
| `public/popup.js` | Popup logic (MV3 CSP: no inline scripts) |
| `src/content/index.js` | `window.wdk` EIP-1193-style provider |
| `docs/README.md` | architecture and message flow |
| `docs/screenshots/` | UI screenshots |
| `docs/demo/` | demo video |
| `docs/PR-WDK-EXAMPLES.md` | upstream PR guide for [wdk-examples](https://github.com/tetherto/wdk-examples) |
| `docs/ESCROW.md` | Escrow deploy, `escrow.json`, Create/Join user flow |
| `docs/DEPLOY-STATUS.md` | Live BSC addresses + pending EVM deploy checklist |
| `docs/KILAVUZ-ESCROW-TR.md` | Turkish step-by-step (deploy + OTC) |
| `escrow-app/` | Escrow UI → `dist/escrow/` after build |
| `public/escrow.json` | Per-network factory/registry addresses |

## Author

- GitHub: [@001453](https://github.com/001453)
- X: [@nhtctnk](https://x.com/nhtctnk)

## License

Apache-2.0 — see [LICENSE](./LICENSE).
