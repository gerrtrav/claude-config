---
name: composer-laravel11-block-insecure
description: While on Laravel 11, a plain `composer update` fails (block-insecure rejects every 11.x); update named packages instead; symfony/console held <7.4
metadata:
  type: project
---

Since 2026-10-21 (SPPRO-4861) every laravel/framework 11.x release carries security advisories (fixes only in 12.60+), and Composer's default `audit.block-insecure` refuses to load them, so a plain `composer update` fails with "affected by security advisories". Update named packages instead (`sail composer update vendor/pkg ... --with-dependencies`), which keeps the locked framework.

composer.json has `"conflict": {"symfony/console": ">=7.4"}` because artisan crashes ("Call to a member function make() on null" in Illuminate\Console\Command::run) with Laravel 11.46.1 + Console 7.4. Remove the conflict when upgrading to Laravel 12 (the user chose to do that in a separate ticket).

Livewire 3.8 checks upload URLs with hasValidRelativeSignature(); app code that signs `livewire.upload-file` URLs must sign relative (App\Support\UploadProfile::signedUrl).

**Why:** a blanket update looks broken but isn't; the console hold is easy to forget at the Laravel 12 upgrade.
**How to apply:** use targeted updates until Laravel 12 lands; at that upgrade drop the console conflict.
