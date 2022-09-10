#!/bin/bash

########### python script to merge climate csv data into all_year.csv file ##############
python_script='combine_all_year_data.py'

########### path where script resides, csv data and all_year.csv file will be created #############
dir_path=$(cd $(dirname "${BASH_SOURCE:-$0}") && pwd)

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
		do wget  --content-disposition "https://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv&stationID=48549&Year=${year}&Month=2&Day=14&timeframe=1&submit= Download+Data";
	done;

	echo "Executing python script $python_script to combine data into all_year.csv"
	python3 $python_script dir_path


	if [ $? -ne 0 ]; then
   		echo "Script failed"
   		exit 1
   	else
   		echo "---------------Finished reading data from API at $(date)-------------------"
   		exit 0
	fi
}


############## main(): function will initialize the script #############
main(){
	while getopts hp flags
	do
   		case "${flags}" in
        	h) year_wise_help
           		exit 0;;
        	p) year_wise_data;;
        	*) year_wise_help
           		exit 0;;
   		esac
	done
}

# program starts here
main $*