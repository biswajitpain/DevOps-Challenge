FROM python:3.7-alpine3.8
##  EXPOSE Port for the Application 
ARG  EXPOSE_PORT
RUN mkdir /srv/app
COPY . /srv/app
WORKDIR /srv/app
RUN  pip install -r requirements.txt
#EXPOSE ${EXPOSE_PORT}
EXPOSE 8000
## Will use gunicorn|wsgi later ## Fixme!!
CMD ["python", "hello.py"]

