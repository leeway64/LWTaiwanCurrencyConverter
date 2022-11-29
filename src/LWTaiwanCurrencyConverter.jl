# Similar to if __name__ == "__main__" in Python
if abspath(PROGRAM_FILE) == @__FILE__
    settings = read_cfg_file("include/settings.cfg")

    if settings["plot_exchange_rate"] == true
        plot_exchange_rate()
    else
        conversion_rate = get_conversion_rate()
        input_dollars = read_input()

        input_output_dict = Dict()
        if settings["USD_to_NTD"] == true
            for entry in input_dollars
            end
        else
        end
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


function print_results(input_output_dict, output_file_path)

end


function plot_exchange_rate()

end
