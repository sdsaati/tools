#!/usr/bin/env python
import os
from dotenv import load_dotenv as env  # I will use my local .env file
import pyautogui
import logging
import argparse


parser = argparse.ArgumentParser()  # Parse Args
parser.add_argument("-e", action="store_true")
parser.add_argument("-p", action="store_true")
args = parser.parse_args()  # All passes arguments
env()  # load my local .env file and then I can use os.getenv("")


def debug(msg):
    logging.basicConfig(
        format="%(asctime)s %(message)s",
        filename="/home/sdsaati/write.py.log",
        filemode="w",
        level=logging.DEBUG,
    )
    logging.debug(msg)


def put_mail():
    # auto write my email whenever I needed
    pyautogui.PAUSE = 1
    pyautogui.FAILSAFE = True
    pyautogui.keyUp("alt")
    pyautogui.write(os.getenv("EMAIL"))


def put_second():
    # write this as automation
    pyautogui.PAUSE = 1
    pyautogui.FAILSAFE = True
    pyautogui.keyUp("alt")
    pyautogui.write(os.getenv("MC"))


def main():
    if args.e:  # email will write
        put_mail()
    elif args.p:  # p will write
        put_second()


if __name__ == "__main__":
    main()
