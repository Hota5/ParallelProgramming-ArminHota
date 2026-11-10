# ParallelProgramming-ArminHota

## What I did
Downloaded Example_03 from the course github and the timestep_opt1/2/3.c files from the book's github. Didn't change any code. For each file I compiled it, linked it and ran it with likwid.

Commands for opt1 as example:
```
gcc -g -O3 -fstrict-aliasing -ftree-vectorize -fopenmp-simd -march=native -mtune=native -mprefer-vector-width=256 -fopt-info-vec-optimized -c timestep_opt1.c -o timestep_opt1_256.o
gcc timestep_opt1_256.o main.o timer.o -o timestep_opt1_256 -lm
sudo likwid-perfctr -C 0 -f -g FLOPS_DP ./timestep_opt1_256
```

Did the same for opt2 and opt3, then ran opt3 again with `-fno-trapping-math -fno-math-errno` added to the first command. The compiler said "loop vectorized using 32 byte vectors" every time, the flags version also got an extra line (`timestep_opt3.c:10:7`).

## Results
| Version | Run time (s) | Scalar ops | Vectorization ratio | MFLOP/s |
|---|---|---|---|---|
| opt1 | 0.3637 | 90,602,646 | ~0 % | 249.15 |
| opt2 | 0.2947 | 90,176,019 | 0 % | 306.02 |
| opt3 | 0.3497 | 90,422,403 | 0 % | 258.57 |
| opt3 + flags | 0.1993 | 21 | 100 % | 452.16 |

## Why opt3 with the flags is the best
opt1, opt2 and opt3 are still almost all scalar in likwid, even though the compiler said it vectorized them. With the two flags it went to 100 % vectorized and about 1.75x faster than normal opt3 (0.1993 s vs 0.3497 s).

The loop has a square root in it. Normally the compiler has to play it safe with that: sqrt of a bad number should set an error and can cause a floating point exception, so it can't just run it on several numbers at once. -fno-math-errno tells it to not care about the errno and -fno-trapping-math tells it to not care about the exceptions. After that it is allowed to run the math on 2 numbers at the same time, that's why the scalar ops dropped from about 90 million to 21 and it got faster. The downside is we lose those error checks, so it is only fine if the program doesn't need them.

Compiler said 32 byte vectors but likwid counted 128-bit, not sure why.

## What this means
The compiler message alone doesn't tell us if the code is really vectorized, we have to check with likwid. Just adding pragmas wasn't enough here, the compiler flags decided if it actually happened.
