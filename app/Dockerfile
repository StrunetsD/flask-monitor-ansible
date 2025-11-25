FROM python:3.11-slim as builder
WORKDIR /build
COPY requirements.txt .
RUN pip install --prefix=/install --no-cache-dir -r requirements.txt
COPY main.py .

FROM python:3.11-slim
WORKDIR /app
COPY --from=builder /install /install
COPY --from=builder /build/main.py .
ENV PATH="/install/bin:$PATH"
ENV PYTHONPATH="/install/lib/python3.11/site-packages"
ENV APP_HOST=0.0.0.0
ENV APP_PORT=5555
CMD gunicorn -b "${APP_HOST}:${APP_PORT}" main:app