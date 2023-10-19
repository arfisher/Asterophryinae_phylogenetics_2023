# Asterophryinae phylogenetics

This repository contains updates to the phylogenetic reconstruction of Asterophryinae.  

- Fall 2022 We determined that the previous _Aphantophryne pansa_ included in Hill et al 2022 was probably not reliable sequence. BPBM 5299 and BPBM 8312 were dropped. 

# Projects:

## oreophryne

Three samples of the type species, _Oreophryne senkenbergiana_ was added to clarify the taxonomy of Oreophryne was was revealed to be polyphyletic in Hill et al 2022, 2023. We also added a sample of _Oreophryne frontifsciata_ from a location near _O. senkenbergiana_, both from the Moluku islands, Indonesia.  Whichever clade (designated _Oreophryne A_ or _B_ in Hill et al 2022) contains the type species will retain the name _Oreophryne_, and the other will be the new genus _Auparoparo_.  

Added:  
- _Oreophryne senkenbergiana_ BJE1120, BJE1143, BJE1144, Halmahera Island, North Maluku
- _Oreophryne frontifsciata_ BJE1248, Halmahera Island, North Maluku

Dropped:  
- _Aphantophryne pansa_ BPBM5299, BPBM8312

## aphantophryne

Hill et al. 2022,2023 found various members of Aphantophryne coming out with _Oreophryne A_ or _B_. Fall 2022 We determined that the previous _Aphantophryne pansa_ samples BPBM 5299 and BPBM 8312 included in Hill et al 2022 was probably not reliable sequence. In addition we obtained new samples of Aphantophryne to include. The major changes:

Added: 
- _Aphantophryne sabini_ Myola guest house, Central Province, Papua New Guinea
- _Aphantophryne pansa_ Mt Yule, north lookout, Central Province, Papua New Guinea
- _Oreophryne senkenbergiana_ BJE1120, BJE1143, BJE1144, Halmahera Island, North Maluku
- _Oreophryne frontifsciata_ BJE1248, Halmahera Island, North Maluku

Dropped:
- _Aphantophryne pansa_ BPBM5299, BPBM8312

In addition we tested serveral samples from older collections of Aphantophryne pansa from English Peaks and ? but could not get reliable sequence from them. These were fixed in formalin. 


# Project structure:

Our phylogenetic workflow involves fitting the best evolutionary model and inferring a Maximum Likelihood phylogeny using IQTREE2.  The ML tree is then used as the starting tree in a dated Bayesian inference analysis using BEAST2. 

The model fit uses IQTREE2ʻs PartitionFinder module. Our dataset contains 2475 nt divided among five loci split by codon to make 15 partitions. PartitionFinder fits the best evolutionary model and combines partitions that can share models to reduce the numbers of parameters to fit and avoid overparameterization. This can result in stronger phylogenetic inference. 

Each phylogenetic folder contains: 
- __input__ - date file, partition file, and symbolic links to other inputs saved in other locations. 
- __mesquite_alignment__ - the DNA alignment files saved in mesquite .nex format. 
	+ mesquite_alignment_datasetname.nex - loci saved separately, for adding data and data maintenance
	+ alignment_datasetname.nex - exported alignment with the partitions added to serve as input to IQTREE2 or BEAUti/BEAST2
- __model_search__ - the IQTREE2 model fit and phylogenetic analysis
	+ README.md explains the IQTREE2 commands and syntax
	+ __iqtreerun_bestmodel.sh__ - a shell script to run the IQTREE2 analysis.  Paths to input files are specified in the shell script. There should be no need to copy and past files. Run from the unix terminal in this directory using `bash iqtreerun_bestmodel.sh`
	+ To start, this folder only contains the shell script. All other files are produced by the script. 
	+ __bestmodel_nomerge__ - modelsearch results without combining partitions. Performs worse than partitionfinder, so we donʻt use this. 
- __beast__ 
	+ __beast_projectname.xml__ - the input xml file must be created using __BEAUti__ with the results of the modelsearch and our inputs. Detailed instructions for how to create this .xml file are here:  <https://docs.google.com/document/d/1xywH3O6_cJWZ_7ZFdmdzQN7VlfNo9LsOPtO7yw9vzTg/edit>
	+ __run1__ - __beastrun.slurm__ runs the analysis on the UH-HPC supercomputer cluster. Customize the jobnames if you want to differentiate them.
	+ __run2__ - __beastrun.slurm__ runs a second independent analysis on the UH-HPC supercomputer cluster
	+ Instructions on how to upload to the UHM HPC (MANA/KOA) and run analyeses are here: <https://docs.google.com/document/d/1cdnyFgO3RD7wWOLYnU0DbHxsuYtBcwty0GvJlPJK8tE/edit>

# Notes

__10-19-2023__ 
- Suspect issue with Beast2 handling of ambiguity codes use IQTREE2.
- Final phylogeny with new Aphantophryne species and Oreophryne type specimens is in __update20231019__ > modelsearch folder.
	+ The .contree shows toplogy and branch lengths, clearer depiction of internal branches
	+ Time-smoothed tree in .timetree.nex
- Former oreophryne folder renamed __oreophryne_without_newaphantophryne__	
- All other folders moved to __old__

__07-22-2023__
- Big update to directory structure. 
	+ Deleted old directories (incorrect phylogenies based on errors in datasets). 
	+ Oreophryne analyses are running, waiting for Aphantophryne analyses to start. 
	+ We worked out errors in specifying the starting tree, corrected the taxa used for dating (check that they are correctly identified to islands) and minimizing the numbers of parameters estimated by BEAST2.  No need to estimate parameters that we are not interested in, or specified by PartitionFinder.  

- Note that there is some translation needed between the IQTREE2 conventions and the BEAST2 model conventions. This is constantly evolving, so need to check every time. 
	+ IQTREE2 <http://www.iqtree.org/doc/Substitution-Models>
	+ BEAST2 <https://www.beast2.org/beast-features/>

- __substitution models__: In PartitionFinder, we used __-m MFP+MERGE__ (as opposted to __-m TESTMERGE__).  The new method performs better, but it includes the FREERATE model, which is a generalizaiton of the GAMMA model. The FREERATE model is not available in BEAST2 (as far as I can tell), so I used the GAMMA and set the number of parameters according to the number of rate classes specified by the FREERATE model (3,4,5, etc). 

- __beast__: beast directories are simplified. The single .xml file is at the top level, and the run1 and run2 folders contain only the .slurm to begin with (the .slurm contains the path to the .xlm). 