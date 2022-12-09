using Plots
using CSV
using DataFrames
using Printf


function get_exchange_rate_data(path_to_CSV)
    CSV_data = CSV.File(path_to_CSV)
    exchange_rate_df = DataFrame(CSV_data)
    exchange_rate_df = exchange_rate_df[:, [:"Series Description", :"TAIWAN -- SPOT EXCHANGE RATE, NT$/US$ "]

    return exchange_rate_df
end

function get_latest_exchange_rate(exchange_rate_df)
    exchange_rate_list = exchange_rate_df[:, :"TAIWAN -- SPOT EXCHANGE RATE, NT$/US$ "]
    exchange_rate = last(exchange_rate_list)
    
    return exchange_rate
end


function NTDtoUSD(NTD, exchange_rate)
	return NTD / exchange_rate
end


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
Read settings file.
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
Print the USD converted to NTD, or vice versa
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
Plot the exchange rate of TWD over time
"""
function plot_exchange_rate(exchange_rates)
    plot(exchange_rates)
end


# Similar to if __name__ == "__main__" in Python
if abspath(PROGRAM_FILE) == @__FILE__
    settings = read_cfg_file("include/settings.cfg")


    if settings["plot_exchange_rate"]
        plot_exchange_rate()
    else
        exchange_rate = get_latest_exchange_rate("include/FRB_H10.csv")
        converter = NTDtoUSD
        if settings["USD_to_NTD"]
            converter = USDtoNTD
        end

        input_dollars = read_input()

        input_output_dict = Dict()
        for entry in input_dollars
            input_output_dict[entry] = converter(entry, exchange_rate)
        end

        print_results(input_output_dict, settings)
    end
end
