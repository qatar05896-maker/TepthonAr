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

# حل مشكلة بايثون 3.13: جلب ملف imghdr المحذوف وزرعه داخل النظام
RUN python3 -c "import urllib.request; urllib.request.urlretrieve('https://raw.githubusercontent.com/python/cpython/v3.12.0/Lib/imghdr.py', '/usr/local/lib/python3.13/imghdr.py')"

# changing workdir
WORKDIR "/root/TeamUltroid"

# start the bot.
CMD ["bash", "startup"]
