# ParallelProgramming-ArminHota

## Lab 07 - OpenMP stencil (loop-level vs high-level)

### What I did
Downloaded Example_06 from the course github and `stencil_opt6.c` from the book's github. In the Makefile I only changed the `SOURCES` line to build the 3 versions:
 
```
SOURCES = stencil_opt2.c stencil_opt4.c stencil_opt6.c
```

Then ran them on the lab PC at school:

```
make rebuild
./stencil_opt2
./stencil_opt4
./stencil_opt6
```

Every run said `Running with 4 thread(s)`. Full output is in `results.txt`. Screenshot: ![screenshot](resultsSceenshot.png)

### Results
| Version | init (s) | flush (s) | stencil (s) | total (s) |
|---|---|---|---|---|
| opt2 | 0.0185 | 70.07 | 139.86 | 209.95 |
| opt4 | 0.0197 | 68.99 | 139.87 | 208.90 |
| opt6 | 0.0196 | 68.62 | 139.63 | 208.53 |

### The 3 versions
- **opt2:** every loop has its own `parallel for`, so a new parallel region starts and ends for every loop, with a barrier after each one.
- **opt4:** one `parallel` region around the iteration loop, so the region is only started once. Flush loop has `nowait`. Only thread 0 does timers and the pointer swap, and there is no barrier after the swap.
- **opt6:** no `omp for`. Each thread calculates its own rows and initializes them itself. Barriers are written by hand.

### Why the results look like this
All three are almost the same, opt4 and opt6 are only about 0.5% and 0.7% faster than opt2. The small gain is in the flush loop (70.07 s -> about 68.6 s). The stencil time is the same everywhere (about 139.7 s), so thread overhead is not the problem, I think it's limited by memory speed. opt6 vs opt4 (208.53 vs 208.90) is probably just noise.

### Questions
**How many threads did the CPU use?**
4.

**What was improved and what strategies were used?**
- One parallel region instead of many (opt4, opt6).
- `nowait` on the flush loop (opt4) and only the barriers that are needed (opt6).
- Each thread works on its own rows and first-touches them (opt6).
- Timers, printing and pointer swap only on thread 0.

**Explicit vs implicit barriers?**
- **Implicit:** added automatically by OpenMP, e.g. at the end of `parallel for`, `omp for` and `parallel`. Everyone waits until all threads are done.
- **Explicit:** I write `#pragma omp barrier` myself, same waiting.
- opt2 and opt4 only have implicit ones (opt4 skips the one after flush with `nowait`). opt6 has 3 explicit ones. The one after the swap is what opt4 is missing, so there other threads could start the next iteration before thread 0 swapped the pointers.

### What this means
Fewer thread restarts and barriers help a bit, but here the memory is the bottleneck, so the "better" versions barely change the time.
