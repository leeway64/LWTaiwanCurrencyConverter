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
download the csv data into the [include](include) folder.
```bash
sudo bash ./lib/get-currency-exchange-rates.sh
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
cat include/input.txt | julia --project=. src/LWTaiwanCurrencyConverter.jl | sudo docker run -i --rm r-base cat
```

The `-i` option for the `docker run` command keeps standard input open, and the `--rm` option
removes the container when it exits (source:
[docker run documentation](https://docs.docker.com/engine/reference/commandline/run/))

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
julia -i --project=. LWTaiwanCurrencyConverter.jl
exit()
```
The `-i` interactive option is for displaying the plot; entering the REPL is one way to display the plot.
Usually, Julia will just open and then immediately close the plot.

`exit()` quits the REPL


## Unit Tests
To run unit tests, run:
```bash
julia --project=. test/test-suite.jl
```


## Credits  
Credit goes to the [US Federal Reserve Bank](https://www.federalreserve.gov/) for providing the
exchange rate data. Refer to [this page](https://www.federalreserve.gov/datadownload/Choose.aspx?rel=H10)
for more information on the dataset used in this project, along with other exchange rate datasets.

Additionally, refer to [this page](https://www.federalreserve.gov/datadownload/) for more
information on other Federal Reserve datasets.


## Third-Party Tools
- [Docker](https://www.docker.com/): Application containerization
- [Plots](https://github.com/JuliaPlots/Plots.jl) (MIT Expat License): Julia data visualization library
- [DataFrames](https://github.com/JuliaData/DataFrames.jl) (MIT License): Julia tabular data structure library
- [CSV](https://github.com/JuliaData/CSV.jl) (MIT Expat License): Julia CSV library
