# Get currency exchange rates from the US Federal Reserve


# Function in Bash
main()
{
    # Download the exchange rates CSV file into the include directory
	sudo wget https://www.federalreserve.gov/datadownload/Output.aspx?rel=H10&series=c5d6e0edf324b2fb28d73bcacafaaa02&lastobs=120&from=&to=&filetype=csv&label=include&layout=seriescolumn&type=package -P ./include/

	# Zip up the CSV file
	zip exchange-rates.zip ./include/*

	# Unzip the CSV file
	unzip ./include/exchange-rates.zip

    echo "Data successfully zipped and unzipped" | cat

	# Compress the CSV into a tarball with gzip
	tar -cvzf exchange-rates.tar.gz ./include/*

	# Extract the tarball's contents
	tar -xvf ./include/exchange-rates.tar.gz

    echo "Data successfully compressed and decompressed through gzip"
	cat data-download-success.message.txt | head | tail
}


main
