import subprocess
from time import sleep
from random import choice, randint
import os

IMG_PATH = os.path.join(os.environ["HOME"], ".config/several/sus/.resources")
def get_links():
    with open("links.txt", "r") as file:
        return file.readlines()
def get_imgs_from_dir(path=IMG_PATH):
    files = os.listdir(path)
    return files


# Example of running a simple command, like 'ls -l'
def call_linkbg(link):
    result = subprocess.run(['linkbg', link, "r"], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    if result.returncode != 0:
        print(f"Error, {result.stderr}")
def call_filebg(path):
    result = subprocess.run(['filebg', path, "r"], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    if result.returncode != 0:
        print(f"Error, {result.stderr}")

def main():
    while 1:
        try:
            if randint(0, 1) == 1:
                link = choice(get_links())
                call_linkbg(link)
                sleep(60)
            else:
                path = choice(get_imgs_from_dir())
                call_filebg(path)
                sleep(60)
        except KeyboardInterrupt:
            print("exiting...")
            return 0
if __name__ == "__main__":
    main()
