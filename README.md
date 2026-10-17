# 598APE-MP2

This repository contains code for homework 2 of 598APE.

In particular, this repository is an implementation of Symbolic Regression and the various contexts it can be used in.

## Build with Docker

Run the following command. Make sure you have Docker installed on your machine.

It builds the required compiler toolchain into a Docker image.

```bash
docker build -t "598ape-ringo-leo-mp2" -f docker/Dockerfile .
```

## Run with Docker

```bash
docker run -it -v ".:/workspace" -t 598ape-ringo-leo-mp2 bash
```

After this, the project root will be in `/workspace`.

## Checkout and Compile Programs

We develop our code on the `main` branch. However, it contains all of the CI code and Makefile changes in the middle of the commit history. For better testing, we reorder the commits and create a new branch called `final`, so that all miscellaneous changes are at the bottom of the tree.

First, checkout the `final` branch.

```bash
git checkout final
```

If Git is unhappy about modifying the Git repository inside the container, run the following command:

```bash
git config --global --add safe.directory /workspace
```

## Test a Specific Optimization

To test the speedup of a specific optimization, we first test the commit where the optimization is introduced and then test `HEAD^`.

The commit hash can be found using `git log`.

Here are all commit hashes for all of our optmizations coresponding to the section number in our report:

* 1.1: 0ba36ffcbadda119490fa2edf14fb07efaae3c57  
* 1.2: 63084c61534271419e6fd56fa764dc341cda6669  
* 1.3: 17135c45486b2d71fd64333743a9bde2405bc952  
* 1.4: 944c9635deb7b26a936e02f622c6930d5a35f7cb  
* 1.5: 87d9fb6d08a9874ef5e8c78bc6f6f5687dccbd5c  
* 2.1: 881456645043a58714c8afecc5b76f03fae384ad  
* 2.2: 285db608f060aa8feb3ab60fbd8d6fd142cc949e  

The testing procedure is:

```bash
git checkout <HASH>
make clean
make
# Run your tests.

git checkout HEAD^
make clean
make
# Run your tests.
```

Here are the possible test cases. We 

```bash
# Diabetes Test
./genetic_benchmark diabetes

# Cancer Test
./genetic_benchmark cancer

# California Housing Prices Test
./genetic_benchmark housing

# Silk Waves Test
./genetic_benchmark silk-wave > silk.rkt

# Square Wave Test
./genetic_benchmark square-wave > square.rkt
```

Alternatively, you can run `./scripts/performance-test.sh` directly.

This script runs the previous 5 tests. Each scene is run three times, and the average value is reported.
