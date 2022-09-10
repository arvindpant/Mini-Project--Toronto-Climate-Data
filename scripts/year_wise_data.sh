#!/bin/bash

########### python script to merge climate csv data into all_year.csv file ##############
PYTHON_SCRIPT='combine_all_year_data.py'

########### path where script resides, csv data and all_year.csv file will be created #############
SCRIPT_PATH=$(cd $(dirname "${BASH_SOURCE:-$0}") && pwd)

########### path to store input data extracted by year_wise_data function ############
INPUT_FOLDER=$(cd "$( dirname "${BASH_SOURCE:-$0}" )" && cd ../INPUT_FOLDER && pwd)


########### path to store output data extracted by year_wise_data function ############
OUTPUT_FOLDER=$(cd "$( dirname "${BASH_SOURCE:-$0}" )" && cd ../OUTPUT_FOLDER && pwd)



###################### year_wise_help(): function will help to understand how to run script ###############
year_wise_help(){
	clear
	echo "year_wise_data.sh"
	echo
	echo "Shell script $0: You will use the shell script to control every operation, including data downloading, log setting, python script running."
	echo
	echo "Python script ${python_script}: While the Python script is used to concatenate all the data into one file."
	echo
	echo "all_years.csv: This is the output file you concatenate all the downloads."
	echo
	echo "Options:"
	echo 
	echo " -p       start the script to process data"
	echo " -h       Help -- this screen"
}

################ year_wise_data(): function will call climate API and generate csv data files ################
year_wise_data(){
	echo "------------------Start reading data from API at $(date)------------------------"
	for year in {2020..2022}; 
		do wget  --content-disposition "https://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv&stationID=48549&Year=${year}&Month=2&Day=14&timeframe=1&submit= Download+Data" -O "${INPUT_FOLDER}/${year}.csv";
	done;


	RC=$?
	if [ ${RC} -ne 0 ]; then
		echo "[ERROR]: Downloading Failed"
		echo "[ERROR]: Return code ${RC}"
		exit 1
	fi
}

################ merge_year_wise_data: function will call python script to merge year wise data created by year_wise_data function ################
merge_year_wise_data(){
	echo "Executing python script $python_script to combine data into all_year.csv"
	python3 "${SCRIPT_PATH}/combine_all_year_data.py" ${INPUT_FOLDER} ${OUTPUT_FOLDER}
	echo "Finished merging data into all_year.csv"

	RC=$?
	if [ ${RC} -ne 0 ]; then
		echo "[ERROR]: Merging failed"
		echo "[ERROR]: Return code ${RC}"
		exit 1
	fi

}


############## main(): function will initialize the script #############
main(){
	while getopts hp flags
	do
   		case "${flags}" in
        	h) year_wise_help
           		exit 0;;
        	p) year_wise_data
				merge_year_wise_data;;
        	*) year_wise_help
           		exit 0;;
   		esac
	done
}

# program starts here
main $*

exit 0