# استخدام نسخة بايثون 3.10 مستقرة وخفيفة
FROM python:3.11

# تحديث النظام وتثبيت الأدوات الأساسية اللي بيحتاجها البوت (زي Git و ffmpeg)
RUN apt-get update && apt-get install -y git bash ffmpeg curl wget

# ضبط التوقيت ليكون بتوقيت مصر
ENV TZ=Africa/Cairo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# نسخ ملف التنصيب
COPY installer.sh .

# تشغيل ملف التنصيب (هيقوم بتحميل السورس والمكاتب المطلوبة)
RUN bash installer.sh

# تحديد مسار العمل
WORKDIR "/root/TeamUltroid"

# تشغيل البوت
CMD ["bash", "startup"]
