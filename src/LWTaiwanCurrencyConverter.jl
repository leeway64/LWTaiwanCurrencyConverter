using Printf


# Similar to if __name__ == "__main__" in Python
if abspath(PROGRAM_FILE) == @__FILE__
    settings = read_cfg_file("include/settings.cfg")

    if settings["plot_exchange_rate"] == true
        plot_exchange_rate()
    else
        conversion_rate = get_conversion_rate()
        converter = NTDtoUSD
        if settings["USD_to_NTD"]
            converter = USDtoNTD
        end

        input_dollars = read_input()

        input_output_dict = Dict()
        for entry in input_dollars
            input_output_dict[entry] = converter(entry, conversion_rate)
        end

        print_results(input_output_dict, settings)
    end
end


function get_conversion_rate()

end


function NTDtoUSD(NTD, conversion_rate)
	return NTD / conversion_rate
end


function USDtoNTD(USD, conversion_rate)
	return USD * conversion_rate
end


"""
Read the input dollars from standard input and return the contents of that file as an array.
"""
function read_input()
    input_dollars = readlines()
    input_dollars = [amount for amount in input_dollars if !startswith(lstrip(amount), "#")]
    
    return input_dollars
end


"""
Read settings file.
"""
function read_cfg_file(cfg_file_path)
	settings = readlines(cfg_file_path)
	settings = [setting for setting in settings if !startswith(lstrip(amount), "#")]
	
	return settings
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
"""
function plot_exchange_rate()

end
