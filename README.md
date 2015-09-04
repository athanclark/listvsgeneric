listvsgeneric
=============

Test list-specific functions against generic ones.

Currently there's only one test - turning something `Foldable` (or a list) into
an `IntMap`.

## Compiling & Running Benchmark

To run the test, make sure you have either stack > 1.3 or GHC >= 7.10 and cabal-install > 1.22.
Then, clone the repo:

```bash
git clone https://github.com/athanclark/listvsgeneric
```

build the library:

#### Cabal-Install

```bash
cabal install --enable-tests --enable-benchmarks
```

#### Stack

```bash
stack build
```

Then benchmark:

#### Cabal-Install

```bash
cabal bench
```

> __Help__: How do I supply arguments to the suite? :(

#### Stack

```bash
stack bench --benchmark-arguments="--output profile.html"
```

This renders a nice report to `./profile.html`.
