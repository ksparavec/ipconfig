#!/bin/bash
dracut -vvvv --force initramfs-ipconfig.img >dracut.log 2>&1
grep ipconfig.sh dracut.log

