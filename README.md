# ParallelProgramming-ArminHota

## What I did

I took the sum code from the lab and added 4 more ways to add up numbers: long double, pairwise, Kahan and Knuth. The program fills an array with big numbers first and tiny numbers after that, adds it up with every method, and prints the error and the run time. I tested array sizes from 2^10 up to 2^27.

## Results

| Method | Error | Run time (s) |
|---|---|---|
| Standard double | -0.01333 | 0.459910 |
| Long double | -8.792e-07 | 0.575553 |
| Pairwise | 0 | 0.717846 |
| Kahan | 0 | 1.326317 |
| Knuth | 0 | 1.992827 |


## Why some methods are better

The computer rounds a little on every addition. When the total gets big, the tiny numbers get rounded away, and with millions of additions the error adds up. That is why the normal sum is the worst.

Long double has more digits so it loses less, but it still rounds a bit.  
Pairwise adds numbers that are about the same size, so less gets lost.  
Kahan and Knuth keep the part that gets rounded off in a separate variable and add it back in later, so nothing is lost.

The better methods are slower because they do more work. Kahan and Knuth were the slowest, so we trade speed for accuracy.


## How this affects parallelization

Adding decimals is not associative, so (a+b)+c can be a little different from a+(b+c). When we split the sum across several processors, the order of the additions changes, so we can get a different answer depending on how many processors we use. This makes results hard to reproduce. Methods like Kahan or pairwise make the answer depend less on the order, so they help with this.
