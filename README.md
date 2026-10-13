# ParallelProgramming-ArminHota

EXPLANATION:  
BUG 1: The two for loops were looping from 0 to 10 but the array size was from 0 to 9  
FIX: Changed "i<=10" to be "i<10"  

BUG 2: In the first for loop it ran "iarray[i] = ipos;" but ipos wasent set to a value beforehand  
FIX: Changed "ipos" into "i"  

BUG 3: At the beginning we used malloc to allocate memory for the array but we never freed the memory  
FIX: Added "free(iarray)" at the end so before the program finishes it frees the memory  

BUGS:    
valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./Task1  
==16287== Memcheck, a memory error detector  
==16287== Copyright (C) 2002-2024, and GNU GPL'd, by Julian Seward et al.  
==16287== Using Valgrind-3.24.0 and LibVEX; rerun with -h for copyright info  
==16287== Command: ./Task1  
==16287==  
==16287== Invalid write of size 4  
==16287==    at 0x1091A2: main (Task1.c:9)  
==16287==  Address 0x4a57068 is 0 bytes after a block of size 40 alloc'd  
==16287==    at 0x4844818: malloc (vg_replace_malloc.c:446)  
==16287==    by 0x109161: main (Task1.c:5)  
==16287==
==16287== Conditional jump or move depends on uninitialised value(s)  
==16287==    at 0x1091D0: main (Task1.c:12)  
==16287==  Uninitialised value was created by a stack allocation  
==16287==    at 0x109149: main (Task1.c:3)  
==16287==
==16287== Invalid read of size 4  
==16287==    at 0x1091CB: main (Task1.c:12)  
==16287==  Address 0x4a57068 is 0 bytes after a block of size 40 alloc'd  
==16287==    at 0x4844818: malloc (vg_replace_malloc.c:446)  
==16287==    by 0x109161: main (Task1.c:5)  
==16287==  
==16287==  
==16287== HEAP SUMMARY:  
==16287==     in use at exit: 40 bytes in 1 blocks  
==16287==   total heap usage: 1 allocs, 0 frees, 40 bytes allocated  
==16287==  
==16287== 40 bytes in 1 blocks are definitely lost in loss record 1 of 1  
==16287==    at 0x4844818: malloc (vg_replace_malloc.c:446)  
==16287==    by 0x109161: main (Task1.c:5)  
==16287==  
==16287== LEAK SUMMARY:  
==16287==    definitely lost: 40 bytes in 1 blocks  
==16287==    indirectly lost: 0 bytes in 0 blocks  
==16287==      possibly lost: 0 bytes in 0 blocks  
==16287==    still reachable: 0 bytes in 0 blocks  
==16287==         suppressed: 0 bytes in 0 blocks  
==16287==  
==16287== For lists of detected and suppressed errors, rerun with: -s  
==16287== ERROR SUMMARY: 14 errors from 4 contexts (suppressed: 0 from 0)  
