# Similar to if __name__ == "__main__" in Python
if abspath(PROGRAM_FILE) == @__FILE__

end


function NTDtoUSD(NTD, conversion_rate)
	return NTD / conversion_rate
end


function USDtoNTD(USD, conversion_rate)
	return USD * conversion_rate
end


"""
Read the file containing the input dollars and return the contents of that file as an array.
"""
function read_input_file()
    input_file_path = "include/input.txt"
    input_dollars = readlines(input_file_path)
    input_dollars = [amount for amount in input_dollars if !startswith(lstrip(amount), "#")]
    
    return input_dollars
end


"""
Read settings file
"""
function read_cfg_file(cfg_file_path)
end


function write_results(output_file_path)
end
