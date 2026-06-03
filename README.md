# myCoinBase — Coinbase iOS Clone

A UIKit-based iOS application that replicates the core screens and user flows of the Coinbase app, built from a Figma community design reference. The project covers authentication, multi-tab navigation, a data-driven home feed, portfolio tracking, and a settings screen — all implemented programmatically in Swift with a clean MVC structure.

Design reference: [Figma Community File](https://www.figma.com/community/file/1165352571580063620)

---

## What I Built

### Authentication Flow (2 paths: Sign In + Sign Up)

**Sign In:**
- Email and password fields with real-time input validation using `NSPredicate` regex — validates email format, password strength (uppercase, special character, number required), and correct credentials
- "Remember Me" toggle that persists credentials to `UserDefaults` and pre-fills fields on next launch
- Show/hide password toggle using `UIButton` state management
- Active/inactive field state — labels and border colors change between blue and grey on focus/blur using `UITextFieldDelegate`
- On success, navigates to a verification screen; on failure, shows a `UIAlertController` with a specific error message

**Sign Up:**
- First name, last name, email and password fields with the same validation logic
- "Looks Good" inline feedback label that appears in real-time as the password meets strength requirements
- Terms agreement checkbox with state tracking — sign-up is blocked until the box is checked
- Navigates to a two-step phone verification screen on success

**Two-Step Verification:**
- Phone number input restricted to 10 numeric digits (enforced via `UITextFieldDelegate`)
- Country code selector — a `UITableView` rendered as a dropdown overlay listing 10 countries with their dial codes; tapping a country code updates the field label and dismisses the overlay
- Navigates to an authentication code entry screen on continue

---

### Tab Bar Navigation (5 tabs)

A `UITabBarController` manages 5 independent navigation stacks:

**1. Home** — 8-section `UITableView` feed:
- Welcome / hero section (430pt tall)
- WatchList — user's tracked assets (e.g. Bitcoin at $38,650.31 with +3.88%)
- Top Movers — a nested `UICollectionView` inside a `UITableViewCell` showing horizontally scrollable crypto cards (KNC +22.37%, ATOM +16.07%, CRV +6.50%)
- Learn about Polygon — promotional card
- Polygon information — detailed content section
- Rewards — rewards card
- Do More — call-to-action section
- News — 5 timestamped articles with source labels, headlines and thumbnail icons

Each section has a custom `UITableViewHeaderFooterView` with per-section font, colour, and optional right-side "View more" labels.

**2. Portfolio:**
- `UITableView` displaying 13 crypto asset rows (USD Coin, Polygon, 0x, 1Inch, Aave, Algorand, Ampleforth, and others) with coin icons, ticker symbols, values, and holdings
- Custom `PortfolioBalanceHeader` as a sticky `UITableViewHeaderFooterView` that dynamically calculates and displays the total balance by summing all item values
- Tapping a row navigates to a detail screen via `performSegue`

**3. Prices:**
- `UICollectionView`-based screen with filter chips for browsing asset prices

**4. Receive Bitcoin:**
- Dedicated screen for receiving crypto

**5. Settings:**
- 5-section `UITableView`: promo banner, payment methods, account settings (6 rows: limits, currency, country, privacy, phone, notifications), security settings (4 rows: PIN/Face ID toggle, privacy mode toggle, support), and sign-out
- Security section includes live `UISwitch` controls — tapping triggers a `UIAlertController` popup via a custom `SecuritySectionDelegate` protocol
- Sign Out resets app state via `UserDefaults` and programmatically replaces the root `UIViewController` to return to the sign-in screen

---

## Architecture

**MVC throughout** — each screen has a dedicated `ViewController` for UI logic only. Data is held in typed model structs and passed to cells via `setValues(model:)` / `setData(model:)` methods. Custom headers and cells are registered via NIB and dequeued with type-safe casting.

**Nested composite cells** — the Top Movers section is a `UITableViewCell` that hosts its own `UICollectionView` with a `UICollectionViewDelegateFlowLayout`, a common production pattern for horizontally scrollable rows inside a vertical feed.

**Delegate protocols** — `SecuritySectionDelegate` and `SignOutBtnDelegate` decouple cell-level user actions from `SettingsScreen`, keeping view controllers clean.

**Keyboard handling** — sign-in and sign-up screens observe `UIResponder.keyboardWillShowNotification` and shift the root view's Y origin to prevent the keyboard from obscuring input fields.

---

## Tech Stack

| Area | Tools |
|---|---|
| Language | Swift |
| UI Framework | UIKit (NIB-based) |
| Architecture | MVC |
| Navigation | UITabBarController, UINavigationController, Segues |
| Persistence | UserDefaults (remember me, auth state) |
| Validation | NSPredicate regex (email + password) |
| Layout | UITableView, UICollectionView, UICollectionViewDelegateFlowLayout |
| IDE | Xcode |

---

## Project Structure

```
CoinBase/
├── AppDelegate + SceneDelegate
├── Auth/
│   ├── Sign In/
│   │   ├── Controllers/  (ViewController, SignInVerification)
│   │   └── Models/
│   └── Sign Up/
│       ├── Controllers/  (SignUpScreen, TwoStepVerification, NewUserAuthentication, EmailVerification)
│       ├── Cells/        (CountryCodesTableViewCell)
│       └── Models/       (CountryCodesModel)
├── Custom Launch Screen/
└── Tab Bar/
    ├── Home Screen/
    │   ├── Controllers/  (HomeScreen)
    │   ├── Cells/        (WelcomeCell, WatchListCell, TopMoversCell, NewsCell, RewardsCell, ...)
    │   ├── Custom Headers/
    │   └── Models/       (NewsDataModel, TopMoversDataModel, WatchListModel, PolygonInfoModel)
    ├── Portfolio/
    │   ├── Controllers/  (PortfolioScreen)
    │   ├── Cells/        (PortfolioItemCell)
    │   ├── Custom Headers/ (PortfolioBalanceHeader)
    │   └── Models/       (PortfolioItemModel)
    ├── Prices/
    │   ├── Controllers/  (PricesScreen)
    │   └── Cells/        (ItemsFiltersCollectionViewCell)
    ├── Receive Bitcoin/
    ├── Settings/
    │   ├── Controllers/  (SettingsScreen)
    │   ├── Cells/        (AccountSecurityCell, PaymentButtonCell, PromoCell, SignOutCell)
    │   ├── Custom Headers/ (SettingsPromoCustomHeader, SettingsPlainHeader)
    │   └── Models/       (AccountSecurityModel)
    └── TabbarController
```

---

## Author

Iman Azher
