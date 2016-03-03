# .. This routine simulates the exponential growth of a bacterial population. It is intended to be 
# .. called by the script 'main.R'
	
# .. reinitialization
 x[]=0
 clones=1
 mut_tot=0 
 x[1,1]=1	

#.. population growth
 for (i in 1:(gen_tot)) {
    	x=r*x 						# growth
    	mut <- rpois(1,lambda=(x[1,1]-x[1,1]/2)*mu)  	# mutations per division!
    	x[1,1]=x[1,1] - mut				# update of population matrix
	mut_tot=mut_tot+mut
	x[x<=0]<-0					
	if (mut>0) { 					# allocation of mutations
		for (z in 1:mut) {
			x[1,clones+z]=x[1,clones+z]+1
				  }  	
	clones=clones+mut
			}
  		}
