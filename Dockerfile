FROM ubuntu:22.04  # Specific version use karo

# Python 3.10 install karo (Python 3.11+ compatible hai)
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
    python3.10 \
    python3-pip \
    ffmpeg \
    aria2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app/

COPY Installer /app/Installer

# Force binary wheel installation
RUN pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir --only-binary=:all: -r Installer

COPY . /app/

CMD ["python3.10", "modules/main.py"]

