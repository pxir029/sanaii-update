#!/bin/bash
set -e

echo "========================================"
echo "  3X-UI Panel - Railway Edition"
echo "  Fork: aavsvs80-coder/3X-ui.3.7.0"
echo "========================================"

# پورت را از Railway بگیر (یا پیش‌فرض 2053)
PORT="${PORT:-2053}"
WEB_BASE_PATH="${XUI_INIT_WEB_BASE_PATH:-/}"

echo "→ Panel Port      : ${PORT}"
echo "→ Web Base Path   : ${WEB_BASE_PATH}"

# ساخت پوشه دیتابیس اگر وجود نداشت
mkdir -p /etc/x-ui
mkdir -p /var/log/x-ui
mkdir -p /root/cert

cd /usr/local/x-ui

# تنظیمات اولیه پنل (اگر دیتابیس جدید باشد)
# -port : پورت پنل
# -webBasePath : مسیر دسترسی به پنل (مثلاً /panel/ )
echo "→ Applying initial settings..."
./x-ui setting -port "${PORT}" -webBasePath "${WEB_BASE_PATH}" 2>/dev/null || true

# نمایش اطلاعات لاگین (اگر دیتابیس تازه باشد)
echo "→ Checking current settings..."
./x-ui setting -show true 2>/dev/null || true

echo ""
echo "========================================"
echo "  Starting 3X-UI on port ${PORT}..."
echo "========================================"
echo ""

# اجرای پنل در foreground
exec ./x-ui
