FROM hashiprobr/redesoc:latest
COPY requirements.txt /
RUN pip install --root-user-action ignore -r /requirements.txt &&\
    rm -f /requirements.txt
