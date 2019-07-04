FROM debian:stretch

RUN apt-get update && apt-get install -y --no-install-recommends \
		dpkg-dev \
		gcc \
		liblinear3 \
		python-liblinear \
		libtcl8.5 \
		default-jre \
		wget \
		sox \
		ffmpeg \
		parallel \
		python2.7

ENV PYTHON_PIP_VERSION 19.1.1
RUN set -ex; \
	\
	wget -O get-pip.py 'https://bootstrap.pypa.io/get-pip.py'; \
	\
	python get-pip.py \
		--disable-pip-version-check \
		--no-cache-dir \
		"pip==$PYTHON_PIP_VERSION" \
	; \
	pip --version; \
	\
	find /usr/local -depth \
		\( \
			\( -type d -a \( -name test -o -name tests \) \) \
			-o \
			\( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
		\) -exec rm -rf '{}' +; \
	rm -f get-pip.py

COPY ./requirements.txt /requirements.txt
COPY ./python_server /python_server
RUN pip install -r /requirements.txt
WORKDIR /python_server
CMD ["python", "-u", "php_python.py"]
