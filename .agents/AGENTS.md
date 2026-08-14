# Project Coding Rules — Canteen Management System (Flutter / GetX)

These rules apply to all new code and refactors in this workspace.

---

## 1. No Hardcoded Strings — Ever
- Every user-facing string goes through `lib/core/constants/app_strings.dart`. No exceptions (snackbars, dialogs, validation, empty states).
- Use `AppStrings.stringName.tr` (e.g. `AppStrings.login.tr`) in widgets for GetX localization support.
- Group by feature/screen with `// Comment` headers.
- Dynamic strings use helper methods in `AppStrings`: e.g. `static String greeting(String name) => 'Welcome, $name'.tr;`.

## 2. No Hardcoded Colors — Always Use Theme
- Never write `Color(0xFF...)` or `Colors.blue` directly in a widget.
- Use `AppColors` (`lib/core/constants/app_colors.dart`) or `Theme.of(context).colorScheme`.
- Text styles use `AppTextStyles` / `Theme.of(context).textTheme`.

## 3. No Magic Numbers for Spacing/Sizing & Responsive Architecture
- Use `AppDimens` tokens (`paddingXs`, `paddingSm`, `paddingMd`, `paddingLg`, `radiusMd`).
- Avoid arbitrary `SizedBox(height: 13)` or `EdgeInsets.all(17)`.
- **Mandated 3-Layer Responsive System**:
  1. `lib/core/constants/app_breakpoints.dart`: Raw breakpoint constants (`tablet = 600`, `landscapeTablet = 900`, `shortScreenHeight = 680`).
  2. `lib/core/utils/responsive.dart`: Reusable `ResponsiveInfo`, `ResponsiveBuilder`, and `r.pick<T>(...)` engine.
  3. Feature-specific metrics classes (e.g. `lib/presentation/pages/<feature>/utils/<feature>_metrics.dart`) consuming `ResponsiveInfo.pick(...)`.

## 4. Reuse Before You Rebuild
- Check `lib/core/widgets/` first: `AppButton`, `AppTextField`, `AppLoader`, `AppDialogs`, `AppToast`.
- If a widget pattern exists on 2+ screens, move/extract to `core/widgets/`.

## 5. Folder Structure
- `lib/core/`: `constants`, `theme`, `network`, `services`, `routes`, `widgets`, `utils`.
- `lib/features/<feature_name>/`: `bindings`, `controllers`, `views`, `widgets`, `models`.

## 6. Naming Conventions
- Files: `snake_case` (e.g. `employee_enrollment_controller.dart`).
- Classes: `PascalCase`.
- Variables/functions: `camelCase`.
- GetX Controllers: `<Feature>Controller`.
- GetX Bindings: `<Feature>Binding`.

## 7. State Management (GetX)
- One controller per screen. No business logic in views.
- Use `.obs` + `Obx(...)` (no `setState`).
- Explicitly handle `isLoading`, `hasError`, and data states for async screens.
- API calls stay inside Repositories/Services, called by Controllers.

## 8. Network Layer
- All requests go through `DioClient`.
- Repositories return typed models or typed failures.
- Use `Logger` (`lib/core/utils/logger.dart`), never raw `print()`.

## 9. Code Style & Quality
- Use `const` constructors everywhere possible.
- `flutter analyze` must pass with zero warnings.
- Null safety: prefer `??`, `?.`, or explicit checks over `!`.
- Imports order: Dart SDK → Flutter → packages → project relative imports.

## 10. Comments & Documentation
- Comment **why**, not **what**.
- Non-trivial functions get a one-line `///` doc comment. Keep files lean and clean.

## 11. Pre-Commit Checklist
- [ ] Strings in `AppStrings`
- [ ] Colors/sizes in `AppColors` & `AppDimens`
- [ ] Responsive layouts use `ResponsiveBuilder` / `ResponsiveInfo`
- [ ] Reused `core/widgets`
- [ ] `flutter analyze` — zero warnings
- [ ] No `print()` calls
- [ ] Route registered & protected by `AuthMiddleware` if needed
- [ ] No `Row`/`Column` child can overflow at 360dp width or with max-length sample text
- [ ] Every async screen has loading / error+retry / empty / success states
- [ ] No `!` null assertions on API, route-argument, or user-input data
- [ ] All list views >15 items use `.builder` constructors
- [ ] Controllers/streams disposed in `onClose()`

---

## 12. UI Robustness & Tablet Adaptability — No Overflow, No Red Screens
- Use `ResponsiveBuilder` instead of raw `LayoutBuilder` boilerplate for adaptive phone/tablet/iPad layouts.
- Never assume a fixed screen size. Wrap scrollable content in `SingleChildScrollView` / `ListView` wherever content can exceed viewport height.
- Inside `Row`/`Column`, wrap children that can grow with `Expanded` or `Flexible` — never let unconstrained widgets (like `Text` or `Image`) sit directly in a `Row` without one.
- Use `Wrap` instead of `Row` when the number of children is dynamic/unbounded (e.g. chip lists, tags).
- For grids/lists with variable-length text, set `overflow: TextOverflow.ellipsis` + `maxLines` on `Text`, or wrap in `Flexible`.
- Never hardcode widget width/height as a fixed pixel value for content-driven UI — use `ResponsiveInfo.pick(...)`, `MediaQuery`, or let the layout size itself (`Expanded`/`Flexible`/`FittedBox`).
- Any `Image.network` / `Image.asset` must have an `errorBuilder` and a fixed `AspectRatio` or `BoxFit` to avoid layout jumps or crashes on load failure.
- Test every new screen mentally (or via widget test) at: small phone width (360dp), tablet width (600dp+), iPad width (820dp–1024dp), and with the longest realistic string — must not overflow.

## 13. Error Handling & Crash Prevention
- No API/DB/file call is ever left without `try/catch`; failures must update `hasError`/error message state — never let an unhandled exception bubble up to the widget tree.
- Every `Obx`/reactive screen must have three explicit branches: loading, error (with retry action), and empty state — never just "success or blank".
- Never use `!` (null assertion) on values coming from API responses, route arguments, or `Get.arguments` — these are exactly the values that cause red-screen crashes at runtime. Use safe defaults or early-return guards instead.
- Route arguments accessed via `Get.arguments` must be null-checked/type-checked before use; navigate back or show an error state if malformed.
- Wrap the app root with a custom `ErrorWidget.builder` (in `main.dart`) so any uncaught render error shows a friendly fallback in release mode, never Flutter's default red screen.
- Global uncaught async errors go through `FlutterError.onError` / `PlatformDispatcher.instance.onError`, logged via `Logger`, never silently swallowed and never left to crash the app.

## 14. Performance
- Use `ListView.builder` / `GridView.builder` for any list that can exceed ~15 items — never `ListView(children: [...])` with a `.map()`.
- Give stable `key`s to list items that can reorder, be inserted, or removed.
- Avoid rebuilding large widget subtrees on every `.obs` change — scope `Obx` as tightly as possible to the smallest widget that actually needs to react, not the whole screen.
- Debounce search/filter text fields (300ms typical) before triggering API calls or heavy filtering.
- Dispose controllers, `TextEditingController`s, `ScrollController`s, and stream subscriptions in `onClose()`.

## 15. Definition of Done (add to Pre-Commit Checklist)
- [ ] No `Row`/`Column` child can overflow at 360dp width or with max-length sample text
- [ ] Every async screen has loading / error+retry / empty / success states
- [ ] No `!` null assertions on API, route-argument, or user-input data
- [ ] All list views >15 items use `.builder` constructors
- [ ] Controllers/streams disposed in `onClose()`

---

## 16. Agentic AI Working Rules (Token Efficiency)
These govern *how* the AI agent should operate on this codebase, not the code itself.

- **Read before writing.** Never regenerate a whole file to make a small change — use targeted diffs/edits on the exact lines that change.
- **No unsolicited rewrites.** Don't reformat, reorder imports, or "clean up" unrelated code in a file you're touching for a different reason. Stick to the requested change only.
- **No unnecessary repo scans.** Don't read the entire `lib/` tree for a single-file fix. Only open files that are directly relevant (the target file + its immediate imports/dependencies).
- **Batch related edits.** If a change touches multiple files (e.g. a new string + its usage), make all edits in one pass instead of re-reading/re-explaining between each file.
- **No narration of obvious steps.** Skip restating the rules file or explaining *what* a widget does before every change — just make the change; explain only non-obvious *why* decisions, briefly.
- **Minimal responses.** After code changes, reply with a short summary of what changed and why — not a full re-print of unchanged code or a restatement of these rules.
- **Reuse existing context.** If a file was already read/edited earlier in the same session, don't re-read it from disk unless it may have changed outside the session.
- **Ask only when truly blocked.** Don't ask clarifying questions for decisions already covered by this rules file (naming, folder placement, widget reuse) — apply the rule directly.
