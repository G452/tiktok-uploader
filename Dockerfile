FROM hub.atomgit.com/amd64/python:3.11.5-slim-bullseye

WORKDIR /app

# 安装必要工具
RUN apt-get update && apt-get install -y wget gnupg libglib2.0-0 libnss3 libgconf-2-4 libfontconfig1 libxrender1 libxext6 libxi6

# 安装 Google Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update && apt-get install -y google-chrome-stable

# 安装 tiktok-uploader
COPY . .
RUN pip install hatch
RUN hatch build
RUN pip install -e .
COPY lib/chrome-linux64 /usr/local/bin/
#CMD ["tiktok-uploader"]
CMD ["tail", "-f", "/dev/null"]
RUN chmod +x /usr/local/bin/chrome-linux64

#docker run -it tiktok-uploader -v video.mp4 -d "hello tiktok" -c cookies.txt

#tiktok-uploader -v video.mp4 -d "hello tiktok" -c cookies.txt