#!/bin/sh

check_args() {
	# Check 2 arguments are given #
	if [ $# -lt 2 ]
	then
		echo "Usage : $0 option section"
		exit
	fi
}

test () {
	case "$1" in
		'section1')
#			_test $1 JGFAll
			_test $1 JGFBarrierBench
			_test $1 JGFForkJoinBench
			_test $1 JGFSyncBench
			;;
		'section2')
#			_test $1 JGFAllSizeA
#			_test $1 JGFAllSizeB
#			_test $1 JGFAllSizeC

			_test $1 JGFCryptBenchSizeA
			_test $1 JGFCryptBenchSizeB
			_test $1 JGFCryptBenchSizeC

			_test $1 JGFLUFactBenchSizeA
			_test $1 JGFLUFactBenchSizeB
			_test $1 JGFLUFactBenchSizeC

			_test $1 JGFSORBenchSizeA
			_test $1 JGFSORBenchSizeB
			_test $1 JGFSORBenchSizeC

			_test $1 JGFSeriesBenchSizeA
			_test $1 JGFSeriesBenchSizeB
			_test $1 JGFSeriesBenchSizeC

			_test $1 JGFSparseMatmultBenchSizeA
			_test $1 JGFSparseMatmultBenchSizeB
			_test $1 JGFSparseMatmultBenchSizeC
			;;
		'section3')
#			_test $1 JGFAllSizeA
#			_test $1 JGFAllSizeB

			_test $1 JGFMolDynBenchSizeA
			_test $1 JGFMolDynBenchSizeB

			_test $1 JGFMonteCarloBenchSizeA
			_test $1 JGFMonteCarloBenchSizeB

			_test $1 JGFRayTracerBenchSizeA
			_test $1 JGFRayTracerBenchSizeB
			;;
		*) echo "$1 is not a valid option"
			exit
			;;
	esac
}

test2 () {
	case "$1" in
		'section1')
			_test $1 $2
			;;
		'section2')
			_test $1 $2
			;;
		'section3')
			_test $1 $2
			;;
		*) echo "$1 is not a valid option"
			exit
			;;
	esac
}



clean () {
	rm -f $1/*.class
	rm -f $1/*/*.class
}

cleanall() {
	rm -f */*.class
	rm -f */*/*.class
}

compile () {
	javac -cp ./:"$1"/ $1/*.java -source 5
	javac -cp ./:"$1"/ $1/*/*.java -source 5
}

_test () {
	rm -f "$1"_"$2"_dump.txt
	java -cp ./:"$1"/ $2 2 >> "$1"_"$2"_dump.txt &
#	sleep 1
	kill -3 $!
#	sleep 1
#	kill -9 $!
}

case "$1" in
	'compile')  echo "Compiling all"
		compile jgfutil
		compile section1
		compile section2
		compile section3
		;;
	'test')  echo  "Testing $2 $3"
		test2 $2 $3
		;;
	'testall') echo "Testing all in $2"
		test $2
		;;
	'clean')  echo  "Cleaning all"
		cleanall
		;;
	*) echo "$1 is not a valid option"
		exit
		;;
esac
