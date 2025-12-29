FROM ubuntu:latest

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
       gcc libffi-dev musl-dev ffmpeg aria2 python3 python3-pip python3-venv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY . /app/
WORKDIR /app/

# FIX: system pip ke bajay venv use
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r Installer

CMD ["python", "modules/main.py"]
