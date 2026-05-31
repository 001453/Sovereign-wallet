# Tether Grant — Project Proposal (copy-paste ready)

Use this text for **[WDK in eCommerce](https://tether.dev/grants/bounties)** (primary fit) or as an extension to the completed **[Browser Extension Starter](https://tether.dev/grants/bounties/2800543167)** track. Adjust the opening line to match the bounty you select.

---

## Short title

**Sovereign Escrow** — permissionless P2P escrow on WDK + official USDt (non-custodial, dual-signature, time-based settlement)

---

## One-paragraph summary (for forms / email)

We propose **Sovereign Escrow**, an open-source escrow protocol and WDK-powered wallet integration for peer-to-peer commerce using **official USDt** on EVM chains. Funds lock in immutable smart contracts—never in a platform wallet. A deal opens only after **both buyer and seller** cryptographically accept the same terms (`termsHash` via EIP-712). Settlement is rule-based: automatic refund if delivery is not marked before the deadline, automatic release after the confirmation window, or mutual settlement with **two signatures**. There is no admin key, no arbitrator company, and no staking or jury layer—reducing complexity and trust assumptions. **Sovereign Wallet** ([GitHub](https://github.com/001453/Sovereign-wallet)) already demonstrates production WDK integration (Ethereum, Polygon, Arbitrum, Bitcoin, Solana) as a Chrome MV3 extension; this grant extends that stack with escrow create/accept/deposit/claim flows and a minimal escrow dApp UI, aligned with Tether’s WDK and USDt ecosystem.

---

## Full proposal

### Problem

P2P sellers and buyers need escrow without trusting a central marketplace. Existing products often rely on a company-held third signature or opaque dispute teams. WDK gives developers multi-chain wallets and USDt transfers, but there is no **reference escrow protocol** that is non-custodial, terms-driven, and easy to integrate from a browser extension.

### Solution

**Sovereign Escrow** — a small, auditable on-chain protocol plus wallet/dApp surfaces:

| Principle | Implementation |
|-----------|----------------|
| Non-custodial | USDt locked in per-deal contracts |
| No operator | Immutable `DealEscrow`; no `adminRelease` / pause |
| No post-deploy admin | `EscrowRegistry.factory` is immutable (no `setFactory`) |
| Mutual consent | Deal active only after **buyer + seller** accept identical `termsHash` |
| Time-based safety | Refund if no delivery by deadline; release if buyer does not confirm in window |
| Mutual exit | `mutualCancel` / `mutualSettle` requires **both** signatures |
| Tether-native | Official USDt on Polygon (v1), then Arbitrum/Ethereum; WDK for signing in Sovereign Wallet |

Each merchant creates their own deal (product description on IPFS, terms in JSON). The protocol is shared; inventory and pricing are per-seller.

### Relation to Sovereign Wallet (WDK)

[Sovereign Wallet](https://github.com/001453/Sovereign-wallet) is an Apache-2.0 Chrome MV3 extension built on **@tetherto/wdk** with:

- Self-custodial vault (AES-256-GCM, PBKDF2)
- Chains: Ethereum, Polygon, Arbitrum (EVM + USDt), Bitcoin, Solana
- `window.wdk` content-script provider (EIP-1193-style) for dApps
- Reference alignment with the Browser Extension Starter bounty scope

This grant adds:

1. **Solidity** — `EscrowRegistry`, `EscrowFactory`, `DealEscrow` (Polygon mainnet testnet first)
2. **Escrow dApp** — create deal, accept terms, deposit, mark delivered, confirm, claim refund/release
3. **Sovereign integration** — typed-data signing, transaction previews, Factory address allowlist, Polygon chain support for escrow txs

### Technical architecture

```
terms.json (IPFS) → termsHash
       ↓
Buyer accept (EIP-712) + Seller accept (EIP-712)
       ↓
bothAccepted → deposit(USDt) → DealEscrow
       ↓
markDelivered → confirm OR autoRelease OR claimRefund (no delivery)
       ↓
optional: mutualSettle (two signatures)
```

**Token:** allowlisted official Polygon USDt (`0xc2132D05D31c914a87C6611C10748AEb04B58e8F`).

**Out of scope for v1:** staking, jurors, cross-chain bridges, TRON adapter (future work).

### Deliverables

| # | Deliverable | Acceptance criteria |
|---|-------------|---------------------|
| 1 | Open-source contracts (`contracts/`) | Foundry tests; NatSpec; no owner on Deal |
| 2 | Polygon Amoy deploy + addresses in `escrow.json` | Public Factory; README deploy steps |
| 3 | Escrow dApp (static or Vite) | Full happy path + refund path on testnet |
| 4 | Sovereign Wallet hooks | EIP-712 accept; `eth_sendTransaction` to Factory/Deal; human-readable tx summary |
| 5 | Documentation | `docs/ESCROW.md` — flows, threats, limitations |
| 6 | Demo video (2–4 min) | Create deal → dual accept → deposit → deliver → confirm (or auto-refund) |

### Security & limitations

- Immutable contracts, allowlisted USDt only, minimum deadlines enforced on-chain
- External audit recommended before mainnet caps are raised; initial `GLOBAL_MAX` per deal
- Protocol does not judge product quality; users must not confirm until satisfied
- Disclosure: deployer does not custody funds; users responsible for phishing and wrong addresses

### License & repo

- **License:** Apache-2.0 (same as Sovereign Wallet)
- **Repo:** https://github.com/001453/Sovereign-wallet (escrow under `contracts/` + `escrow-app/` or dedicated branch)

### Timeline (suggested, ~6–8 weeks)

| Week | Milestone |
|------|-----------|
| 1–2 | Spec + Foundry `DealEscrow` + tests |
| 3 | Amoy deploy + dApp deposit/refund path |
| 4 | Dual EIP-712 accept + mutual settle |
| 5 | Sovereign Wallet integration + tx decoding |
| 6 | Docs, demo video, mainnet-ready checklist (optional capped mainnet) |

### Why Tether / WDK

- Drives **real USDt usage** in commerce scenarios WDK is meant to support
- Complements the **Browser Extension Starter** with a concrete DeFi/commerce primitive
- No competing custodial service—aligned with self-custody and official stablecoins
- Reusable by any WDK wallet, not only Sovereign

### Team / experience

- **Sovereign Wallet** — shipped MV3 extension with WDK multi-chain support, grant-ready demo, [wdk-examples PR](https://github.com/tetherto/wdk-examples/pull/11) contribution path documented in repo
- **GitHub:** [@001453](https://github.com/001453)
- **X:** [@nhtctnk](https://x.com/nhtctnk)

---

## Form fields (suggested answers)

**Website:** https://github.com/001453/Sovereign-wallet  

**Relevant experience (short):**  
Built Sovereign Wallet—a production Chrome MV3 self-custodial wallet on @tetherto/wdk (EVM USDt, BTC, SOL). Implementing encrypted vault, dApp provider, and multi-chain send/receive. Now extending the stack with a non-custodial USDt escrow protocol (dual-signature terms, time-based refund/release, no central operator).

---

## Bounty mapping

| Bounty | Fit |
|--------|-----|
| **WDK in eCommerce** | Primary — P2P escrow for sellers/buyers with USDt |
| Browser Extension Starter | Foundation already built (Sovereign Wallet) |
| Template Wallet | Partial overlap; we target extension + contracts |

---

## Links to include in submission

- Repository: https://github.com/001453/Sovereign-wallet  
- WDK: https://wdk.tether.io  
- Demo (wallet): `docs/demo/` in repo  
- Architecture: `docs/README.md`
