# Mini-Project--Toronto-Climate-Data
## This program contains 2 script in script directory
1. year_wise_data.sh
2. combine_all_year_data.py

## Note: We need to run year_wise_data.sh which will internally call combine_all_year_data.py.

### Shell script: You will use the shell script to control every operation, including data downloading, log setting, python script running.
### Python script: While the Python script is used to concatenate all the data into one file.
### all_years.csv: This is the output file you concatenate all the downloads.


## How to run program 
1. To get help 
	year_wise_data.sh -h 
2. To start processing data
	year_wise_data.sh -p
3. TO get logs 
	./year_wise_data.sh -p >> <path_name>/year_wise_data_$(date "+%d%m%Y%H%M%S").log 2>&1
