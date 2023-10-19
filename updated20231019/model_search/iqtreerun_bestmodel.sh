# Best merged model
iqtree2 -s ../mesquite_alignment/alignment_20230803.nex -spp ../input/asterophryinae_15partitions.nex -m MFP+MERGE -B 1000 -pre redo/merge -o "UMMZ219489_Scaphiophryne_marmorata" --date ../input/asterophryinae_dates.txt --date-tip 0 -mset JC,F81,K80,HKY,TN,TNe,TPM2,TPM2u,TPM3,TPM3u,TIM,TIMe,TIM2,TIM2e,TIM3,TIM3e,TVMe,TVM,SYM,GTR ; 
