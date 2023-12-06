#!/bin/bash

for i {1..255}; do (ping -c 192.168.1.${i} | grep "bytes from" &); done
