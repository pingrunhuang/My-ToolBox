# /bin/sh

get_random(){
	if [ $# != 1 ]
	then 
		echo 'You shall only provide one prameter!'
		exit 0
	fi
	echo first parameter is: $1
	if [ $1 -eq 1 ]
	then 
		return $RANDOM
	fi
}

get_random 1
