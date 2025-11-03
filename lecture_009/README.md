# List

##

```bash
# Compile
nvcc -o simple_reduce simple_reduce.cu

# Run
./simple_reduce
```

```bash
# Basic profiling
ncu ./simple_reduce


ncu --set full ./simple_reduce

# Detailed metrics
ncu --metrics smsp__cycles_elapsed.avg,dram__bytes_read.sum,dram__bytes_write.sum ./simple_reduce

# Save to file
ncu -o profile_output ./simple_reduce
# ncu --import profile_output.ncu-rep

# Interactive analysis (if you have NCU UI)
ncu-ui profile_output.ncu-rep
```