import os
import re
import sys
import pyutil


for i in sys.argv[1:]:
    if os.path.isdir(i) or not i.endswith(".pdf"):
        continue
    print("==========================\n")
    with open(i, "rb") as sources:
        lines = sources.readlines()
    with open("out.pdf", "wb") as sources:
        for line in lines:
            sources.write(re.sub(b"/Fit", b"/XYZ", bytes(line)))
    os.remove(i)
    os.rename("out.pdf", i)
    print("##########################\n")
