#!/bin/bash

. /home/jovyan/bin/activate

jupyter notebook --ip 0.0.0.0 --port ${PORT}
