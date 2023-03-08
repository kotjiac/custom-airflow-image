FROM apache/airflow:2.5.0-python3.10
USER root
RUN apt update
RUN apt install -y libaio1 wget2 unzip
RUN wget2 https://download.oracle.com/otn_software/linux/instantclient/217000/instantclient-basic-linux.x64-21.7.0.0.0dbru.zip
RUN unzip instantclient-basic-linux.x64-21.7.0.0.0dbru.zip
RUN mkdir /opt/oracle
RUN mv instantclient_21_7 /opt/oracle/
RUN cd /opt/oracle/instantclient_21_7
RUN ln -s libclntsh.so.12.1 libclntsh.so
RUN ln -s libocci.so.12.1 libocci.so
RUN echo /opt/oracle/instantclient_21_7 > /etc/ld.so.conf.d/oracle-instantclient.conf
RUN ldconfig
USER 50000
RUN cd /tmp/
COPY requirements.txt .
RUN pip install -r requirements.txt
