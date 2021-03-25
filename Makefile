run:
	gnatmake src/*
	src/main

build:
	gnatmake src/*

clean:
	rm -rf src/*.o
	rm -rf src/*.ali
