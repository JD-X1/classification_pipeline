#! usr/bin/env python
import os
import pandas as pd
import sys

mags_list = os.listdir("mags/")
rule all:
    input:
        expand("braker_out/{mags}/", mags = mags_list)

rule gmes:
    input:
        "mags/{mags}"
    output:
        directory("braker_out/{mags}/")
    conda:
        "envs/braker.yaml"
    shell:
        "braker.pl --genome=m{input} --workingdir={output} --GENEMARK_PATH=/global/u2/j/jduque/EukClass/gmes_linux_64_4/gmes_petap.pl --AUGUSTUS_ab_initio --esmode --gff3 -threads 64"
