# LWTaiwanCurrencyConverter

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/leeway64/LWTaiwanCurrencyConverter)


LWTaiwanCurrencyConverter converts US dollars (USD) to New Taiwan Dollars (TWD) and vice versa.
In addition, LWTaiwanCurrencyConverter can also plot the NTD to USD exchange rate (NTD per USD) as
it changes over time.

The terms TWD and NTD (New Taiwan Dollar) are used interchangeably in this project.

## Installation

```bash
git clone https://github.com/leeway64/LWTaiwanCurrencyConverter.git
cd LWTaiwanCurrencyConverter
```


## Downloading the latest Federal Reserve data

First, download the latest Federal Reserve data onto your local machine. The following command will
download the csv data into the [include](folder).
```bash

```


## LWTaiwanCurrencyConverter Usage

User settings are contained in [settings.cfg](include/settings.cfg). Let's assume you want to
convert USD to NTD. So, you would set `USDtoNTD` to `true`:
```text
# Application settings file

USDtoNTD = true
plot_exchange_rate = false
```


All user input is entered into [input.txt](include/input.txt).
```text
# User input file. Input dollar amounts should be in either USDs or NTDs.

1000
20.99
324.9
```


Then, LWTaiwanCurrencyConverter reads input.txt from standard input.
```bash
cat include/input.txt | julia project=. LWTaiwanCurrencyConverter.jl | docker run --rm r-base /bin/bash cat
```

The final results are printed to standard output through the Docker container:
```text

```


## Plotting NTD exchange rates over time

First, make sure that `plot_exchange_rate` is set to `true` in [settings.cfg](include/settings.cfg):
```text
# Application settings file

USD_to_NTD = true
plot_exchange_rate = true
```

To plot the NTD exchange rates, run:
```bash
julia --project=. LWTaiwanCurrencyConverter.jl
```


## Unit Tests

```bash
julia --project=. test/test-suite.jl
```

## Third-Party Tools
- [Docker](https://www.docker.com/): Application containerization.
