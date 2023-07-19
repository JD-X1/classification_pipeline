#!usr/bin/env bash


#################################### IMPORTANT ####################################
# This script is used to create the Artio mamba environment.
###################################################################################


################################### GeneMark-ES ###################################
# 
# Download the GeneMark-ES software and liscence from GeneMark website:
#
#    http://exon.gatech.edu/GeneMark/license_download.cgi
#
# Follow the instructions in the installation guide:
#    https://github.com/gatech-genemark/GeneMark-E-Docs/
#
#
#
##################################################################################



################################ Expected File Tree ##############################
# -- workflow                                                                  ###
#    |-- rules                                                                 ###
#        |-- annotation.smk                                                    ###
#        |-- mag_stats.smk                                                     ###
#    |-- scripts                                                               ###
#        |-- Artio.sh                                                          ###
#    |-- envs                                                                  ###
#        |-- Artio.yml                                                         ###
#        |-- EuKCC.yml                                                         ###
#        |-- Titania.yml                                                       ###
#    |-- mags                                                                  ###
#        |-- MAGs (fasta files)                                                ###
#    |-- modules                                                               ###
#        |-- busco_parse.py                                                    ###
#        |-- mag_stats.py                                                      ###
#        |-- eukcc_parse.py                                                    ###
#        |-- xg_parse.py                                                       ###
#    |-- mb_downloads                                                          ###
#        |-- eukaryota_odb10                                                   ###
#    |-- eukccdb                                                               ###
#        |-- eukcc2_db_ver_1.1                                                 ###
#    |-- PhyloFisherDatabase_v1.0                                              ###
#    |-- gmes_linux_64_4  ### See Above                                        ###
#    |-- 4CAC                                                                  ###
##################################################################################



module load python

mamba create -c conda-forge -c bioconda -n Artio --file ../envs/Artio.yml

sh gmes_linux_64_4/check_install.bash

change_path_in_perl_scripts.pl ~/.conda/envs/Artio/bin/perl