FROM python:3.11

# تثبيت الأدوات الأساسية
RUN apt-get update && apt-get install -y \
    git bash ffmpeg curl wget \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV TZ=Africa/Cairo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY installer.sh .

# السطر ده هيحمل السورس من النت زي ما هو متبرمج
RUN bash installer.sh

# الخدعة هنا: البحث عن أي أوامر خروج (exit أو sys.exit) في ملف قاعدة البيانات وتحويلها لكلمة pass (عشان البوت يتجاهلها ويكمل)
RUN find /root/TeamUltroid/pyUltroid -name "*.py" -exec sed -i 's/sys.exit(0)/pass/g' {} +
RUN find /root/TeamUltroid/pyUltroid -name "*.py" -exec sed -i 's/exit(0)/pass/g' {} +

WORKDIR "/root/TeamUltroid"

CMD ["bash", "startup"]
