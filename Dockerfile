FROM drewantech/flask_sqlalchemy:1.0.1
MAINTAINER Benton Drew <benton.s.drew@drewantech.com>
USER root
RUN rm test_sqlalchemy.py && \
  apk add --no-cache ca-certificates wget gcc python3-dev musl-dev postgresql postgresql-dev && \
  update-ca-certificates && \
  wget http://initd.org/psycopg/tarballs/PSYCOPG-2-6/psycopg2-2.6.2.tar.gz && \
  tar xvzf psycopg2-2.6.2.tar.gz && \
  cd psycopg2-2.6.2/ && \
  python3 setup.py install && \
  cd - && \
  rm -r psycopg2-2.6.2/ && \
  rm psycopg2-2.6.2.tar.gz && \
  apk del --no-cache ca-certificates wget gcc python3-dev musl-dev postgresql-dev
ADD service/test_psycopg2.py .
ENV FLASK_APP test_psycopg2.py
USER python_user
ENTRYPOINT ["python3", "-m", "flask", "run"]
CMD ["--host=127.0.0.2", "--port=5001"]
