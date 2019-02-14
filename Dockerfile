FROM python:3.6

# Install system packages
RUN apt-get update && apt-get install -y supervisor

WORKDIR /opt/python/app/

# Install python dependencies.
RUN pip install celery

# Copy supervisord configuration.
COPY supervisord.conf /etc/supervisord.conf

COPY requirements.txt /opt/python/app/
RUN pip install -r requirements.txt

# Copy app
COPY app ./app/

EXPOSE 8000
ENV C_FORCE_ROOT=1

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]