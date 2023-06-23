#! usr/bin/env python
import os
import pandas as pd
import sys



# make a rule that sets up cluster parameters
# use the --slurm flag to run on the cluster

# locally we can just use the follow environment breakdowns due to incompatible python versions

# local
# Titania (python 3.7.10)
# Apollo (python 3.9.16)
    # minibusco
	
# call mains from modules folder using shell calls 

# create a list of files in directory mags ending in .fna


mags_list = os.listdir("mags/")
print (mags_list)
rule all:
    input:
        expand("busco_out/{mag}/summary.txt", mag=mags_list),
        expand("eukcc_out/{mag}/", mag=mags_list),
        expand("xgb_out/{mag}.out", mag=mags_list),
        "mag_stats_x.csv"

rule run_busco:
    input: 
        "mags/{mag}"
    output:
        "busco_out/{mag}/summary.txt"
    conda:
        "mb"
    threads:
        64
    shell:
        "compleasm run -a {input} -t {threads} -l eukaryota -L mb_downloads/ -o busco_out/{wildcards.mag}"

rule run_eukcc:
    input:
        "mags/{mag}"
    output:
        directory("eukcc_out/{mag}/")
    threads:
        64
    conda:
        "Titania"
    shell:
        "eukcc single --out {output} --threads {threads} {input}"

rule run_xgb_class:
    input:
        "mags/{mag}"
    output:
        "xgb_out/{mag}.out"
    conda:
        "Titania"
    shell:
        "python 4CAC/classify_xgb.py -f {input} -o {output}"

rule mag_stat:
    input:
        "mags/"
    output:
        "mag_stats.csv"
    shell:
        "python modules/mag_stats.py -f {input}"

rule mag_stat_b:
    input:
        magstat=rules.mag_stat.output
    output:
        "mag_stats_b.csv"
    conda:
        "Titania"
    shell:
        "python modules/busco_parse.py -b busco_out/ -m {input.magstat} -o {output}"


rule mag_stat_e:
    input:
        magstat=rules.mag_stat_b.output
    output:
        "mag_stats_e.csv"
    conda:
        "Titania"
    shell:
        "python modules/eukcc_parse.py -e eukcc_out -m {input} -o {output}"
        
rule mag_stat_x:
    input:
        magstat=rules.mag_stat_e.output
    output:
        "mag_stats_x.csv"
    conda:
        "Titania"
    shell:
        "python modules/xg_parse.py -x xgb_out -m {input} -o {output}"
