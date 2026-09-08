FROM alpine:3.19

LABEL maintainer="aavsvs80-coder"
LABEL description="3X-UI Panel optimized for Railway - from your fork"

# نصب وابستگی‌ها
RUN apk add --no-cache \
    curl \
    bash \
    ca-certificates \
    socat \
    tzdata \
    sqlite \
    tar \
    unzip \
    && ln -sf /usr/share/zoneinfo/Asia/Tehran /etc/localtime \
    && echo "Asia/Tehran" > /etc/timezone

# دانلود باینری از فورک شما
# اگر هنوز Release نساختی، از نسخه رسمی v3.7.0 استفاده می‌کنه
# بعد از ساخت Release در گیت‌هاب خودت، لینک رو عوض کن
ARG XUI_VERSION=v3.7.0
ARG GITHUB_USER=aavsvs80-coder
ARG GITHUB_REPO=3X-ui.3.7.0

RUN set -eux; \
    echo "Downloading 3x-ui ${XUI_VERSION}..."; \
    # اول سعی می‌کنه از فورک شما دانلود کنه، اگر نبود از رسمی می‌گیره
    if curl -fsSL -o /tmp/x-ui.tar.gz \
        "https://github.com/${GITHUB_USER}/${GITHUB_REPO}/releases/download/${XUI_VERSION}/x-ui-linux-amd64.tar.gz"; then \
        echo "Downloaded from your fork"; \
    else \
        echo "Fork release not found, falling back to official MHSanaei/3x-ui"; \
        curl -fsSL -o /tmp/x-ui.tar.gz \
            "https://github.com/MHSanaei/3x-ui/releases/download/${XUI_VERSION}/x-ui-linux-amd64.tar.gz"; \
    fi; \
    tar -xzf /tmp/x-ui.tar.gz -C /usr/local/; \
    rm -f /tmp/x-ui.tar.gz; \
    chmod +x /usr/local/x-ui/x-ui; \
    # ساخت پوشه‌های لازم
    mkdir -p /etc/x-ui /var/log/x-ui /root/cert

# کپی اسکریپت استارت
COPY start.sh /start.sh
RUN chmod +x /start.sh

# پورت پیش‌فرض (Railway خودش PORT رو می‌ده)
EXPOSE 2053

# توجه: دستور VOLUME در Railway پشتیبانی نمی‌شود
# حتماً از بخش Volumes در داشبورد Railway استفاده کنید
# مسیر پیشنهادی: /etc/x-ui

CMD ["/start.sh"]
