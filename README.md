# Description

Pipeline is meant to string together some 

# Downloading the pipline

```
git clone https://github.com/JD-X1/classification_pipeline.git
```


# Adding in your MAGs for Analysis

Copy your MAGs into a directory called 'mags'.
```
mkdir mags
cp ./path/to/your/mags/*.fasta mags/
```


Running the pipeline from within this folder on nersc should be a matter of submitting nersc_runner as job:
```
sbatch nersc_runner.sub
```

__IMPORTANT: __ 