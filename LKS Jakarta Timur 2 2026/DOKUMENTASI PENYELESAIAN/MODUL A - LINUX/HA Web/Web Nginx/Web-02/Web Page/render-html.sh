#!/bin/bash

export hostname=$(hostname)
envsubst < /var/www/www-lksjakarta/index.html.template > /var/www/www-lksjakarta/index.html
