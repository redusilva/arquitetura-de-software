FROM python:3.10

WORKDIR /app

COPY . .

# COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=localhost
ENV PYTHONUNBUFFERED=1

EXPOSE 4002

CMD ["gunicorn", "src.app:app", "--bind", "0.0.0.0:4002", "--log-level", "debug", "--access-logfile", "-"]
