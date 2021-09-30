default: soc
CASE=hello
BIN=ysyxSoC/flash/$(CASE)-flash.bin
HOME=/home/lishi

soc:
	cd ../Zhoushan && $(MAKE) soc
	cp ../Zhoushan/build/ysyx_000000.v ./projects/soc/vsrc
	./build.sh -e soc -b -s -y -v '--timescale "1ns/1ns" -Wno-fatal --trace' -a "-i $(BIN) --dump-wave -b 0 -e 50000"

run:
	cd ./projects/soc/build_test && ./emu -i $(BIN) --dump-wave -b 0 -e 50000

link:
	-rm -rf libraries
	mkdir libraries
	ln -s $(HOME)/NEMU ./libraries/NEMU
	ln -s $(HOME)/ysyxSoC ./libraries/ysyxSoC
	ln -s $(HOME)/Zhoushan/difftest ./libraries/difftest
	ln -s $(HOME)/Zhoushan/DRAMsim3 ./libraries/DRAMsim3

clean:
	./build/sh -e soc -c

.PHONY: soc run link clean
