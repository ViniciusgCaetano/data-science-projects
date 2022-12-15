FROM python

WORKDIR /app

COPY . .

RUN pip install -r app/requirements.txt

EXPOSE 8600

CMD ["streamlit", "run", "app/App.py", "--server.port=8600", "--server.address=0.0.0.0"]
