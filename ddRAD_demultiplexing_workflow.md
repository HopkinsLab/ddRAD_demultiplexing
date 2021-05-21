This is a pipeline to perform demultiplexing of sequence data generated using ddRAD approach. This pipeline has been customized for the Phlox ddRAD data. The relevant scripts can be found in the sub-folders in this directory.

#1) Installation 

	You will need to have conda installed on the cluster if you don't already have it.
	Log into your account on the cluster, navigate to your user directory on scratch (for example, /n/holyscratch01/hopkins_lab/ben/) and follow the instructions to install conda here: https://docs.conda.io/projects/conda/en/latest/index.html
	
	Cluster has conda in it

```bash		
		module load Anaconda3/5.0.1-fasrc02
```
	Then, create new conda environment with latest version of ipyrad. Name it something like 'ipyrad01'. No brackets in name.

```bash	
		conda create -n [env_name] python=3.6 
		source activate [env_name] 
	(to end it)			source deactivate [env_name]
		conda install ipyrad –c bioconda 
```	
	View packages in [env_name] to check which version of ipyRAD was installed (the above command will install the latest version)

```bash	
		conda list -n [env_name]
```


#2) Demultiplexing and trimming - need STACKS, maybe installed on the cluster
```bash		
	module load gcc/7.1.0-fasrc01 stacks/2.4-fasrc01
```
	Path to raw reads on the cluster: /n/holystore01/LABS/hopkins_lab/Lab/schaturvedi/ddRAD_sam_april_2021/raw_reads

**a) Move N's to header of raw reads**

We want to:
1) split our raw reads files so we can modify them in chunks in parallel (faster)
2) zip the split files to prepare them for Beth's script
3) run Beth's script to move N's to header of reads
4) concatenate the edited files (these are now ready for demultiplexing with STACKS)

Here is a description of each step and the corresponding bash scripts for each step:

*1) Split input files to run the 'Move_Ns' script "in parallel"*

We can do this interactively on a test node:
```bash
srun -p test -n 1 -N 1 --pty --mem 8000 -t 0-04:00 /bin/bash
```

Then navigate to the directory containing your raw reads files as we received them from the sequencing core and run the following to split them into 3-5 files each.

```bash
# you just need to replace the [bracketed] text with however your raw reads files are named
zcat [R1_raw_reads].fastq.gz | split -l 300000000 - [R1_raw_reads]_ --additional-suffix=.fastq
zcat [R2_raw_reads].fastq.gz | split -l 300000000 - [R2_raw_reads]_ --additional-suffix=.fastq
```

*2) zip the split files using pigz*
Use the script **2a_pigz_fastq.sh** to run this remotely on the cluster:

```bash
#!/bin/bash
#SBATCH -p serial_requeue	# Partition to submit to
#SBATCH -n 16               # Number of cores
#SBATCH -N 1                # Ensure that all cores are on one machine
#SBATCH -t 2-0:00           # Runtime in days-hours:minutes
#SBATCH --mem 32000         # Memory in MB
#SBATCH -J pigz             # job name
#SBATCH -o pigz_%A.out         # File to which standard out will be written
#SBATCH -e pigz_%A.err         # File to which standard err will be written
#SBATCH --mail-type=ALL        				# Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[your email]	# Email to which notifications will be sent

source new-modules.sh
module load GCC/8.2.0-2.31.1 pigz/2.4


cd /n/holyscratch01/hopkins_lab/[directory that contains only your split raw reads files ending in .fastq]


pigz -p 16 --best *.fastq
```
*3) Move N's to header*
Now we get to run Beth's script (Move_Ns_to_header_both_seqs.py) and edit our raw reads files. To do this, first, put the python script on the cluster and make sure it's executable:

```bash
chmod u+x 2a_Move_Ns_to_header_both_seqs.py
```
Next, we run the **2a_send_move_Ns_Beths.sh** on the cluster:

```bash
#!/bin/bash
#SBATCH -p shared			       			# Partition to submit to
#SBATCH -n 5	                   			# Number of cores
#SBATCH -N 1                   				# Ensure that all cores are on one machine
#SBATCH -t 7-00:00               			# Runtime in days-hours:minutes
#SBATCH --mem 64000              			# Memory in MB
#SBATCH -J move_Ns             				# job name
#SBATCH -o move_Ns_%A.out        			# File to which standard out will be written
#SBATCH -e move_Ns_%A.err        			# File to which standard err will be written
#SBATCH --mail-type=ALL        				# Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[your email]			# Email to which notifications will be sent


source new-modules.sh
module load python/2.7.14-fasrc02

cd /n/holyscratch01/hopkins_lab/[directory containing subdirectory 'scripts' and subdirectory 'demultiplex' or however you want to organize]

# run Beth's script to move N's from sequence to header
# 2a_Move_Ns_to_header_both_seqs.py

# python path/to/Move_Ns_to_header_both_seqs.py path/to/split_raw_reads_R1_aa.fastq.gz path/to/split_raw_reads_R2_aa.fastq.gz &
python scripts/2a_Move_Ns_to_header_both_seqs.py demultiplex/raw_reads_split/Ben_S2_L001_R1_001_aa.fastq.gz demultiplex/raw_reads_split/Ben_S2_L001_R2_001_aa.fastq.gz &
python scripts/2a_Move_Ns_to_header_both_seqs.py demultiplex/raw_reads_split/Ben_S2_L001_R1_001_ab.fastq.gz demultiplex/raw_reads_split/Ben_S2_L001_R2_001_ab.fastq.gz &
python scripts/2a_Move_Ns_to_header_both_seqs.py demultiplex/raw_reads_split/Ben_S2_L001_R1_001_ac.fastq.gz demultiplex/raw_reads_split/Ben_S2_L001_R2_001_ac.fastq.gz &
python scripts/2a_Move_Ns_to_header_both_seqs.py demultiplex/raw_reads_split/Ben_S2_L001_R1_001_ad.fastq.gz demultiplex/raw_reads_split/Ben_S2_L001_R2_001_ad.fastq.gz &
python scripts/2a_Move_Ns_to_header_both_seqs.py demultiplex/raw_reads_split/Ben_S2_L001_R1_001_ae.fastq.gz demultiplex/raw_reads_split/Ben_S2_L001_R2_001_ae.fastq.gz &

wait

```


*4) Concatenate edited files*
You could probably do this interactively on a test node, but I just run it on the cluster. Takes about 20-30 minutes. For this we run the **2a_cat_Ns_header.sh**.

```bash
#!/bin/bash
 
#SBATCH -n 16                   # Number of cores
#SBATCH -N 1                    # Ensure that all cores are on one machine
#SBATCH -t 2-00:00              # Runtime in D-HH:MM
#SBATCH -p shared		        # Partition to submit to
#SBATCH --mem=32000             # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o cat_v11_%A.out     	# File to which STDOUT will be written
#SBATCH -e cat_v11_%A.err    	# File to which STDERR will be written
#SBATCH --mail-type=ALL         # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=[your email]     # Email to which notifications will be sent


cd /n/holyscratch01/hopkins_lab/[directory containing split and edited reads, the output of Beths Move_Ns script]


cat raw_reads_split/Ben_S2_L001_R1_001_aa.fastq.gzedited raw_reads_split/Ben_S2_L001_R1_001_ab.fastq.gzedited raw_reads_split/Ben_S2_L001_R1_001_ac.fastq.gzedited raw_reads_split/Ben_S2_L001_R1_001_ad.fastq.gzedited raw_reads_split/Ben_S2_L001_R1_001_ae.fastq.gzedited > reads_cat/Ben_S2_L001_edited_R1.fastq
cat raw_reads_split/Ben_S2_L001_R2_001_aa.fastq.gzedited raw_reads_split/Ben_S2_L001_R2_001_ab.fastq.gzedited raw_reads_split/Ben_S2_L001_R2_001_ac.fastq.gzedited raw_reads_split/Ben_S2_L001_R2_001_ad.fastq.gzedited raw_reads_split/Ben_S2_L001_R2_001_ae.fastq.gzedited > reads_cat/Ben_S2_L001_edited_R2.fastq

```

Moved the reads from reads_cat folder to demultiplex folder for next step.

**b) Demultiplexing**

We use STACKS to demultiplex our samples. Matt/Beth wrote some scripts to call these commands. I have shared an example set (names beginning with '2b_'). You will also need to write a simple text file containing sample names and barcodes. See example (2b_barcodes_example.txt).

		relevant files:
		2b_send_Nstacks_example.slurm	this is the slurm script you will submit to the cluster, it will call the other scripts
		2b_run_stacks_1PR_example.sh 	this is the script that will run the 'process radtags' function in STACKS, make sure it's executable
		2b_run_stacks_2CF_example.sh 	this is the script that will run the 'clone filtering' function in STACKS, make sure it's executable
		2b_barcodes_example.txt 		this is the barcodes key. column 1 = PstI barcode [tab], column 2 = MspI barcode [tab], column 3 = sample_name


	c) Trimming

		After demultiplexing, we use trimmomatic to trim the demultiplexed files. I think ipyRAD would also do this, but we have decided to trust trimmomatic more, so we do this first. I have shared an example script to call trimmomatic for each file. It's kind of a hassle to write - I use an excel sheet to write/organize the repeptitive commands, but you could also write a script to generate the commands if you are more fancy than me.

		relevant files:
		2c_install_trimmomatic.sh 		this is a walkthrough for installing trimmomatic on the cluster. DON'T execute this file, open and work through it. 
		2c_trimmomatic_example.sh 		this is what a script will look like to run trimmomatic on each demultiplexed file
		2c_write_trimmomatic_example.xlsx	this is how I generate the series of trimmomatic commands. Change all columns except for 'start' and 'end' of command



#3) Running ipyRAD

	a) Generate a 'params' file

		Create a directory to house your ipyRAD assembly, name it something like 'ipyRAD_assembly01', and navigate there. You may want to run multiple assemblies 

		Activate your ipyRAD environment:

			source activate [env_name]

		Initiate a new assembly, which will generate an associated params file:

			ipyrad -n [name_of_assembly]

		Edit your params file (https://ipyrad.readthedocs.io/en/latest/6-params.html). I will share an example of one of mine. Most values can be left as the default. The crucial values to change are:

			[4] = path to directory that contains your demultiplexed, trimmed files
			[7] = pairddrad
			[8] = TGCAG, CGG 
			[14] = something between 0.85 and 0.93 (this is the major parameter to tweak that could affect the assembly)
			[16] = 2
			[17] = 36 (this matches the parameters we use in trimmomatic)
			[21] = 4 (I always run one assembly with min_sample_depth = 4 and then rerun the last steps with a series of larger values)
			[27] = * (a '*'' will ask for all output formats. Why the hell not?)


	b) Run the 7 steps of ipyRAD

		Simply acitivate your conda environment and call the deceptively simple ipyRAD command. We write slurm scripts to request time/memory to run ipyRAD on the cluster because it is resource intensive depending on the size of your dataset.

		Steps 1 & 2 are very fast, step 3 takes the longest. If you're feeling lucky, you could ask for a lot of memory and time and call them all at once. I typically break it up into 4 scripts as follows: 1+2, 3, 4+5, 6+7. I have shared examples.

		relevant files:
		3b_ipyrad_S12_example.sh
		3b_ipyrad_S3_example.sh
		3b_ipyrad_S45_example.sh
		3b_ipyrad_S67_example.sh



