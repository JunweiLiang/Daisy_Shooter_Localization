FROM php:5.5-apache
RUN apt-get update && apt-get install -y --no-install-recommends php5-mysql