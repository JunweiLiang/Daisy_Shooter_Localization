FROM python:2.7-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
		dpkg-dev \
		gcc 
RUN apt install -y --no-install-recommends liblinear3      liblinear3 \

CMD ["/bin/bash"]
