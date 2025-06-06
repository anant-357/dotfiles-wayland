#!/bin/bash

sudo hciconfig hci0 down
sleep 1
sudo bluemoon -A
sleep 1
sudo hciconfig hci0 up
sleep 1
sudo systemctl restart bluetooth
