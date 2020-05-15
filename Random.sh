#!/bin/bash

folder="/home/alejandro/Dropbox/photos"

ls $folder/*.jpg | shuf -n 20 
