# First stage: build stage
FROM python:3.9.16-slim AS build

RUN mkdir /build
WORKDIR /build

COPY app /build

COPY app/requirements.txt /build

RUN pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org -r requirements.txt

# Second stage: final stage
FROM python:3.9.16-slim

RUN groupadd -r appusergroup \
&& useradd -g appusergroup appuser \
&& mkdir /app \
&& chown -R appuser:appusergroup /app \
&& chmod -R 755 /app

WORKDIR /app

COPY --from=build /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages

COPY app /app

EXPOSE 5000

USER appuser

CMD [ "python", "app.py" ]
