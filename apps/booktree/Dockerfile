ARG VERSION

FROM python:3.12-alpine

RUN apk add --no-cache ffmpeg git

WORKDIR /app
RUN git clone https://github.com/myxdvz/booktree.git . && \
    if [ "${VERSION}" != "main" ]; then git checkout "${VERSION}"; fi && \
    pip install --no-cache-dir -r requirements.txt

ENTRYPOINT ["python", "booktree.py"]
