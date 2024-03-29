# LWTaiwanCurrencyConverter

```text
==============================================================================================================================================
 _    __      __ _____        _                       ___                                        ___                            _             
| |   \ \    / /|_   _| __ _ (_)__ __ __ __ _  _ _   / __| _  _  _ _  _ _  ___  _ _   __  _  _  / __| ___  _ _  __ __ ___  _ _ | |_  ___  _ _ 
| |__  \ \/\/ /   | |  / _` || |\ V  V // _` || ' \ | (__ | || || '_|| '_|/ -_)| ' \ / _|| || || (__ / _ \| ' \ \ V // -_)| '_||  _|/ -_)| '_|
|____|  \_/\_/    |_|  \__,_||_| \_/\_/ \__,_||_||_| \___| \_,_||_|  |_|  \___||_||_|\__| \_, | \___|\___/|_||_| \_/ \___||_|   \__|\___||_|  
                                                                                          |__/                                                
Taiwan is awesome! Visit Taiwan!
Remember to vote in 2024!
==============================================================================================================================================
```

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

LWTaiwanCurrencyConverter is written mostly in Julia; although it is not necessary to set up this
project, refer to [this document](doc/julia-project-workflow.asciidoc) to learn more about the
Julia project workflow.

## Downloading the latest Federal Reserve data

First, download the latest Federal Reserve data onto your local machine. The following command will
download the csv data into the [include](include) folder.
```bash
sudo bash ./lib/get-currency-exchange-rates.sh
```


## LWTaiwanCurrencyConverter usage

User settings are contained in [settings.cfg](include/settings.cfg). Let's assume you want to
convert USD to NTD. So, you would set `USDtoNTD` to `true`:
```text
# Application settings file

USDtoNTD = true
plot_exchange_rate = false
```

Make sure that `plot_exchange_rate = false`.


All user input is entered into [input.txt](include/input.txt).
```text
# User input file. Input dollar amounts should be in either USDs or NTDs.

1000
20.55
324.9
99.99
```


Then, LWTaiwanCurrencyConverter reads `input.txt` from standard input.
```bash
cat include/input.txt | julia --project=. src/LWTaiwanCurrencyConverter.jl | sudo docker run -i --rm r-base cat
```

The `-i` option for the `docker run` command keeps standard input open, and the `--rm` option
removes the container when it exits (source:
[docker run documentation](https://docs.docker.com/engine/reference/commandline/run/))

The final results are printed to standard output through the Docker container:
```text
USD converted to NTD
1000.0 -> 31433.0
20.55 -> 645.95
324.9 -> 10212.58
99.99 -> 3142.99
```

If you wanted to convert NTDs to USDs, then change `USDtoNTD = true` to `USDtoNTD = false`.


## Plotting NTD exchange rates over time

![USD-to-TWD-exchange-rate-last-10-years](doc/USD-to-TWD-exchange-rate-last-10-years.png)

First, make sure that `plot_exchange_rate` is set to `true` in [settings.cfg](include/settings.cfg):
```text
# Application settings file

USD_to_NTD = true
plot_exchange_rate = true
```
If `plot_exchange_rate` is set to true, then it will override all other settings, forcing the
application to only display the plot.

To plot the NTD exchange rates, run:
```bash
julia -i --project=. src/LWTaiwanCurrencyConverter.jl
exit()
```
The `-i` interactive option runs the REPL and is for displaying the plot; entering the REPL is one
way to display the plot. Usually, Julia will just open and then immediately close the plot.

`exit()` quits the REPL.


## Unit tests
To run unit tests, run:
```bash
julia --project=. test/test-suite.jl
```


## Printing project logo
**Prerequisite**: redis-server

To print the project logo seen at the top of this repository, run the following commands:
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python lib/print_logo.py
```


## Credits  
Credit goes to the [US Federal Reserve Bank](https://www.federalreserve.gov/) for providing the
exchange rate data. Refer to [this page](https://www.federalreserve.gov/datadownload/Choose.aspx?rel=H10)
for more information on the dataset used in this project, along with other exchange rate datasets.

Additionally, refer to [this page](https://www.federalreserve.gov/datadownload/) for more
information on other Federal Reserve datasets.


## Third-party software
- [Docker](https://www.docker.com/): Application containerization
- [Plots](https://github.com/JuliaPlots/Plots.jl) (MIT Expat License): Julia data visualization library
- [DataFrames](https://github.com/JuliaData/DataFrames.jl) (MIT License): Julia tabular data structure library
- [CSV](https://github.com/JuliaData/CSV.jl) (MIT Expat License): Julia CSV library
- [DataStructures](https://github.com/JuliaCollections/DataStructures.jl) (MIT License): Collection of several data structures for Julia
- [Measures](https://github.com/JuliaGraphics/Measures.jl) (MIT Expat License): Julia library for measurement types
- [ART](https://pypi.org/project/art/) (MIT License): ASCII art Python module
- [redis-py](https://pypi.org/project/redis/) (MIT License): Python package to interact with Redis
