## set shell
#!/bin/bash

# Shell script to run all the different species 
# while setting the various parameters

# Now set PBS options
# set job name
#$ -N peruDispersal

## use current working directory
#$ -cwd

# set to the bash shell for PBS
#$ -S /bin/bash

# send to general queue
#$ -q all.q

## Request the required number of cpus per job
#$ -pe smp 8

# combine standard error and output files
#$ -j y

# send email at end of job and if aborted
#$ -m ae
# to email address
#$ -M  robert.bagchi@uconn.edu

## load R
module load R/3.2.2

echo "Running  Peru spatial analyses"

# set global parameters for analysis
export nclust=$NSLOTS

## set default values for various variables
## these can be overriden from the command line
## To run the code with default values of noqw and nopl but
## resetting nsim and rmax do
## qsub -v nsim=999,rmax=10 peruDispersal.sh
${noqw:0}
${nopl:0}
${nsim:99}
${rmax:15}

echo 'number of cpus requested = ' $nclust

R CMD BATCH ~/Peru/July2016/PeruAnalysis/PeruDispersal_v6_bbcsrv3.R ~/Peru/July2016/perudisp\_v6\_pl$nopl\_niter$nsim\_rmax$rmax\.Rout

