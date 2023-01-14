FROM python:3.6

RUN mkdir -p /app/templates

WORKDIR /app
COPY main.py .
COPY requirement.txt .
ADD templates templates
RUN pip install -r requirement.txt
RUN mkdir ~/.aws
# RUN ~/.aws/credentials

EXPOSE 5000
CMD [ "python", "main.py" ]
