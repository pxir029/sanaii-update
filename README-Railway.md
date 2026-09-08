# 3X-UI — فایل‌های دیپلوی Railway

این فایل‌ها از ریپوی اصلی 3X-UI (سنایی) گرفته شده‌اند.

## محتویات
- `railway.json`     → تنظیمات بیلد و دیپلوی Railway
- `Dockerfile`       → بیلد چندمرحله‌ای (Frontend + Go)
- `DockerEntrypoint.sh`
- `DockerInit.sh`
- `docker-compose.yml` (برای استفاده لوکال یا جایگزین)
- `.dockerignore`

## نحوه استفاده در Railway

1. ریپوی کامل 3X-UI را به Railway وصل کنید (Deploy from GitHub).
2. این فایل‌ها باید در **ریشه** ریپو باشند (همین‌طور که هست).
3. در Settings سرویس:
   - Branch: `main`
   - Automatic Deployments: روشن
4. Volume برای دیتابیس بسازید و به مسیر `/etc/x-ui` مانت کنید.
5. پورت `2053` را Publish کنید یا Domain بسازید.

## نکات
- با هر `git push` به main، Railway خودکار بیلد و دیپلوی می‌کند.
- بدون Volume، دیتابیس با هر دیپلوی پاک می‌شود.
- بیلد حدود ۲ تا ۵ دقیقه طول می‌کشد.
