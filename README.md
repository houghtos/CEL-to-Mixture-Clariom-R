# R-CEL-to-Mixture-Clariom-Affymetrix-Chips
R script for converting newer Clariom Affymetrix RMA CEL files to CIBERSORT Mixture File 

Note: 
I find this to be the most robust and consistent method for preparing Clariom Affymetrix microarrays. 

Certain Affyimetrix Clariom arrays do not support certain levels (e.g. Clariom S does not support "probset" level).

To obtain summaries at the probeset level, the user should set the RMA target argument to 'probeset'.

Transcript level summaries are also possible. 
  - For Exon arrays, there are three possible options for transcript level summarization: 
    1. core 
    2. full 
    3. extended. 
    
  - For Gene arrays, only summaries for 'core' probesets is available.
