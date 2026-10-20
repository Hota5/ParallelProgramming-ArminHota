# ParallelProgramming-ArminHota

hwloc/lstopo  
Ran the given commands, had to run autogen.sh since git clone has no configure script, and add the lib path so lstopo would run.  

STREAM   
Ran clean, no issues.

Roofline   
Default config was default config was for icpc/old gnuplot neither matched what was installed on the lab pc, so I swapped the compiler flags to gcc/mpicxx then it worked.  

CloverLeaf + Callgrind  
Ran it first with the default cycle count, it froze the pc and I had to reboot. Changed cycles to 10 and reran, it worked but took a long time to finish. Ran low on time, forgot to actually visualize the result in KCacheGrind and screenshot it, moved on to Task 5.  

likwid   
MEM_DP group doesn’t exist for my CPU so used FLOPS_DP instead. Hit a memory shortage running CloverLeaf, shrank the grid from the default ~16k down to 100, got the table after that.  
