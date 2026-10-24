FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=8000

RUN apt-get update \
    && apt-get install -y --no-install-recommends unzip \
    && rm -rf /var/lib/apt/lists/*

COPY portfolio-tracker-v5-cloud.zip /tmp/portfolio-tracker.zip
RUN mkdir -p /app \
    && unzip /tmp/portfolio-tracker.zip -d /tmp/portfolio-src \
    && cp -a /tmp/portfolio-src/portfolio-tracker-v5-cloud/. /app/ \
    && rm -rf /tmp/portfolio-tracker.zip /tmp/portfolio-src

WORKDIR /app
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000
CMD ["sh", "-c", "uvicorn app:app --host 0.0.0.0 --port ${PORT:-8000}"]
