#!/bin/bash
sudo add-apt-repository ppa:jonathonf/ffmpeg-3
apt-get update
apt-get upgrade
apt-get install ffmpeg libav-tools x264 x265
ffmpeg -version
ffmpeg -i /dev/video*
