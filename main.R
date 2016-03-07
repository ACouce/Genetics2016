# .. This program simulates the experimental measurement of genetic diversity in an asexual, exponentially-expanding population.
# .. It calls the script 'LD.R' to obtain simulated clone-size distributions and directs the data to the script 'random.R',
# .. which simulates the random picking of two mutants from these distributions. Diversity is estimated as the Simpson's Index, 
# .. i.e. the probability of sampling, without reposition, two mutants of the same clone.

# .. Reference:
# .. Couce, A.; Rodriguez-Rojas, A. and Blazquez J.(2016). 'Determinants of genetic diversity of spontaneous drug-resistance 
# .. in bacteria'. Genetics.

# .. clear previous sessions
rm(list=ls())

# .. start the stopwatch
 clock <- Sys.time()

# .. parameters
 t_ld=23 			# generations in the Luria-Delbruck period
 mu=1/(2^t_ld) 			# mutation rate
 clases=20*round(mu*2^(35)) 	# expected number of different clones (needed to allocate data)
 sample_size=2 
 replica=100
 
# .. variables
 x <- matrix(0,1,clases) 	# population matrix
 counter <- matrix(0,5,14) 	# results matrix
 
# .. program
 n=0 				# counter of the parameter regimes to be explored
 for (growth_rate in c(1.2,1.6,2,3,5)) { 	# this loop iterates among growth rates  
	r <- matrix(growth_rate,1,clases) 	# growth rate matrix
	r[1,1]=2 				# wild-type's growth rate
	n=n+1 

	for (g in c(1:14)) { 			# this loop iterates among population sizes (generations)
		gen_tot=g+t_ld
	
		for (rep in 1:replica) { 
			# .. population growth
			mut_tot=0
			while (mut_tot<=1) {source("LD.R")}

			# .. sampling colonies
			sample <- matrix(1,1,sample_size) # reinitalization!
			source('random.R') 
	 		
			# .. analysis
			if (sample[1]==sample[2]) {counter[n,g]=counter[n,g]+1}
					}
		# .. report progress		 
		print(c(growth_rate, gen_tot-t_ld, counter[n,g]))
		}
         }

# .. save the data
write.table(counter, file = "data", sep = " ")

# .. stop the stopwatch
print(Sys.time()-clock)
