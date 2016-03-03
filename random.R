# .. This routine simulates random draws without reposition of two mutants from a bacterial population. It is intended  
# .. to be called by the script 'main.R' 

# .. variables
 random <- matrix(0,1,sample_size)

# .. load mutant subpopulation
 mutants<-x[,2:clones]

# .. normalize mutant subpopulation
 y<-x[,2:clones]/sum(x[,2:clones])
 for (i in 2:mut_tot) { y[i]<-y[i]+y[i-1] }  

# .. pick first colony	 
 random[1]<-runif(1,0,max(y))

 while (y[sample[1]]<random[1])				# scan trough the normalized mutant subpopulation  
 { sample[1]=sample[1]+1 } 

 if (mutants[sample[1]]==1) 				# finish because it's picked a only child!
	{sample[2]=sample[1]+1 				
 } else {						# proceed to pick up second colony
	# .. update mutant subpopulation (sampling without reposition!)
        mutants[sample[1,1]]=mutants[sample[1,1]]-1 	

	# .. re-normalize mutant subpopulation
	y<-mutants/sum(mutants) 
	for (i in 2:mut_tot) { y[i]<-y[i]+y[i-1] }

	# .. pick second colony
	random[2]<-runif(1,0,max(y))

	while (y[sample[2]]<random[2]) 
	{ sample[2]=sample[2]+1 } 
       }
