# fit best model and infer phylogeny
iqtree2 -s ../../mesquite_alignment/alignment_asterophryinae_20230720.nex -spp ../../input/asterophryinae_15partitions.nex -m MFP -B 1000 -pre nomerge -o "UMMZ219489_Scaphiophryne_marmorata" --date ../../input/asterophryinae_dates.txt --date-tip 0 -mset JC,F81,K80,HKY,TN,TNe,TPM2,TPM2u,TPM3,TPM3u,TIM,TIMe,TIM2,TIM2e,TIM3,TIM3e,TVMe,TVM,SYM,GTR ; 
