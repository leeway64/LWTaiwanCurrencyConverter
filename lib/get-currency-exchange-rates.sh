# Get currency exchange rates from the US Federal Reserve


# Function in Bash
main()
{
    # Download the exchange rates CSV file into the include directory
	curl -o ./include/FRB_H10.csv "https://www.federalreserve.gov/datadownload/Output.aspx?rel=H10&series=c5d6e0edf324b2fb28d73bcacafaaa02&lastobs=120&from=&to=&filetype=csv&label=include&layout=seriescolumn&type=package"


	# Zip up the CSV file
	zip ./include/exchange-rates.zip ./include/FRB_H10.csv
    rm ./include/FRB_H10.csv

	# Unzip the CSV file
	unzip ./include/exchange-rates.zip
    rm -r ./include/exchange-rates.zip

    echo "Data successfully zipped and unzipped" | cat


	# Compress the CSV into a tarball with gzip
	#     c: Create archive
	#     v: Verbose
	#     z: gzip
	#     f: Use archive file
	tar -cvzf ./include/exchange-rates.tar.gz ./include/FRB_H10.csv
    rm ./include/FRB_H10.csv


	# Extract the tarball's contents
	#     x: Extract
	#     v: Verbose
	#     f: Use archive file
	tar -xvf ./include/exchange-rates.tar.gz
	rm -r ./include/exchange-rates.tar.gz

    echo "Data successfully compressed and decompressed through gzip"
	cat ./lib/data-download-success.message.txt | head | tail
}


main
