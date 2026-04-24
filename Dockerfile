# Ultroid - UserBot
# Copyright (C) 2021-2022 TeamUltroid
# This file is a part of < https://github.com/TeamUltroid/Ultroid/ >
# PLease read the GNU Affero General Public License in <https://www.github.com/TeamUltroid/Ultroid/blob/main/LICENSE/>.

FROM theteamultroid/ultroid:main

# ضبط التوقيت ليكون بتوقيت مصر
ENV TZ=Africa/Cairo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY installer.sh .

RUN bash installer.sh

# حل مشكلة بايثون 3.13 عن طريق تثبيت المكتبة الناقصة يدوياً
RUN pip3 install imghdr

# changing workdir
WORKDIR "/root/TeamUltroid"

# start the bot.
CMD ["bash", "startup"]
