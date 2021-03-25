run:
	gprbuild -p ultra_strategy.gpr
	obj/main

build:
	gprbuild -p ultra_strategy.gpr

clean:
	rm -rf obj/*
	mkdir -p obj
