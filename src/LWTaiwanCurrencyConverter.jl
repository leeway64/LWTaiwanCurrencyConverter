# Similar to if __name__ == "__main__" in Python
if abspath(PROGRAM_FILE) == @__FILE__

end


function NTDtoUSD(NTD, conversion_rate)
	return NTD / conversion_rate
end


function USDtoNTD(USD, conversion_rate)
	return USD * conversion_rate
end


function read_input_file(input_file_path)
end


"""
Read settings file
"""
function read_cfg_file(cfg_file_path)
end


function write_results(output_file_path)
end
