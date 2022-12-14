using Plots
using CSV
using DataFrames
using Measures
using Printf


"""
Read the exchange rate data from the Federal Reserve Bank into a DataFrame.
The first DataFrame column is the Series Description (including the time period), and the second
column is the info pertaining to Taiwan (including the exchange rate).
"""
function get_exchange_rate_data(path_to_CSV)
    CSV_data = CSV.File(path_to_CSV)
    exchange_rate_df = DataFrame(CSV_data)

    # Only get the data we need
    exchange_rate_df = exchange_rate_df[:, [:"Series Description", :"TAIWAN -- SPOT EXCHANGE RATE, NT\$/US\$ "]]
    return exchange_rate_df
end


"""
Get the most recent exchange rate from the Federal Reserve data.
"""
function get_latest_exchange_rate(exchange_rate_df)
    exchange_rate_list = exchange_rate_df[:, :"TAIWAN -- SPOT EXCHANGE RATE, NT\$/US\$ "]
    exchange_rate = last(exchange_rate_list)
    return parse(Float64, exchange_rate)
end


"""
Converts NTD to USD by dividing by the NTDs per USD exchange rate
"""
function NTDtoUSD(NTD, exchange_rate)
	return NTD / exchange_rate
end


"""
Converts USD to NTD by multiplying by the NTDs per USD exchange rate
"""
function USDtoNTD(USD, exchange_rate)
	return USD * exchange_rate
end


"""
Read the input dollars from standard input and return the contents of that file as an array.
"""
function read_input()
    input_dollars = readlines()
    input_dollars = [parse(Float64, amount) for amount in input_dollars if !startswith(lstrip(amount), "#") && amount != ""]
    
    return input_dollars
end


"""
Read settings file and return a dictionary of each setting and its value.
"""
function read_cfg_file(cfg_file_path)
	settings = readlines(cfg_file_path)
	settings = [setting for setting in settings if !startswith(lstrip(setting), "#") && setting != ""]
	
	settings_dict = Dict()
	for setting in settings
	    key, value = split(setting, "=")
	    key = lstrip(rstrip(key))
	    value = lstrip(rstrip(value))
        if value == "true"
            value = true
        elseif value == "false"
            value = false
        else
            println("Error with input file. Input file values must be \"true\" or \"false\".")
            exit(1)
        end
	    settings_dict[key] = value
	end
	
	return settings_dict
end


"""
Print the USD converted to NTD (or vice versa) in a nice format.
"""
function print_results(input_output_dict, settings)
    if settings["USD_to_NTD"]
        println("USD converted to NTD")
    else
        println("NTD converted to USD")
    end

    for (key, value) in input_output_dict
        @printf("%s -> %s\n", key, value)
    end
end


"""
Plot the exchange rate of TWD over time.
"""
function plot_exchange_rate(exchange_rate_df)
    series_description = exchange_rate_df[:, :"Series Description"]
    taiwan_data = exchange_rate_df[:, :"TAIWAN -- SPOT EXCHANGE RATE, NT\$/US\$ "]

    # Find the index of the "Time Period" value
    starting_index = findall(y->y=="Time Period", series_description)[1]
    
    # Get the dates by only getting the values after "Time Period"
    dates = series_description[starting_index + 1 : length(series_description)]
    exchange_rates = taiwan_data[starting_index + 1 : length(series_description)]
    
    # Convert original string value to decimal value
    exchange_rates = map(z->parse(Float64, z), exchange_rates)

    # Specify the margin size so the xlabel and ylabel don't get cut off
    plot(dates, exchange_rates, legend = false, size = (1500, 1000), lc = "red", margin = 5mm)
    plot!(title = "USD to TWD exchange rates vs. last 12 months", lw = 9)  # plot! mutates the plot object
    xlabel!("Last 12 months")
    ylabel!("Exchange rate (NTDs per USD)")
    savefig("doc/USD-to-TWD-exchange-rate-last-12-months.png")
    gui()  # Display the plot
end


# Similar to if __name__ == "__main__" in Python
if abspath(PROGRAM_FILE) == @__FILE__
    exchange_rate_df = get_exchange_rate_data("include/FRB_H10.csv")
    settings = read_cfg_file("include/settings.cfg")


    if settings["plot_exchange_rate"]
        plot_exchange_rate(exchange_rate_df)
    else
        exchange_rate = get_latest_exchange_rate(exchange_rate_df)
        converter = NTDtoUSD
        if settings["USD_to_NTD"]
            converter = USDtoNTD
        end

        input_dollars = read_input()

        input_output_dict = Dict()
        for entry in input_dollars
            input_output_dict[entry] = round(converter(entry, exchange_rate), digits=2)
        end

        print_results(input_output_dict, settings)
    end
end
