OUT=DeadlockTest

all: $(OUT)

$(OUT): $(OUT).java
	javac $<

run: $(OUT)
	echo "Press Ctrl+C to finish!"
	java $(OUT)

clean:
	rm -f *.class

test: $(OUT)
	./test.sh
