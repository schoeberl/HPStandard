

# cleanup
EXTENSIONS=class rbf rpt sof pin summary ttf qdf dat wlf done qws

#
#	Set USB to true for an FTDI chip based board (dspio, usbmin, lego)
#
USB=false


# Assembler files
APP=add
# Altera FPGA configuration cable
#BLASTER_TYPE=ByteBlasterMV
BLASTER_TYPE=USB-Blaster

ifeq ($(WINDIR),)
	USBRUNNER=./USBRunner
	S=:
else
	USBRUNNER=USBRunner.exe
	S=\;
endif

# The VHDL project for Quartus
QPROJ=dspio
QPROJ=altde2-70

all: tools compiler yarisim rom 
	make sim
#	make yamp


# download and build the binutils
compiler:
	scripts/build.sh

# download YARI and build the SW simulator yarisim
yarisim:
	scripts/yarisim.sh

elf2vhdl:
	-mkdir -p ctools/build
	cd ctools/build && cmake ..
	cd ctools/build && make
	-mkdir -p bin
	cp ctools/build/src/elf2bin bin

tools:
	make elf2vhdl
	-rm -rf java/classes
	-rm -rf java/lib
	mkdir java/classes
	mkdir java/lib
	javac java/src/util/*.java -d java/classes
	cd java/classes && jar cf ../lib/yamp-tools.jar *

# Assemble a program and generate the instruction memory VHDL table
rom:
	-rm -rf vhdl/generated
	mkdir vhdl/generated
	-mkdir -p tmp
	yamp-tools/bin/mipsel-elf-as asm/$(APP).s -o tmp/$(APP).o
	yamp-tools/bin/mipsel-elf-ld tmp/$(APP).o -o tmp/$(APP).out
	yamp-tools/bin/mipsel-elf-objdump -d tmp/$(APP).out
	bin/elf2bin tmp/$(APP).out tmp/$(APP).bin
	java -cp java/lib/yamp-tools.jar \
		util.Bin2Vhdl -s tmp -d vhdl/generated $(APP).bin

# Compile a C program, the MIPS compiler must be in the path
comp:
	-mkdir -p tmp
	cd c; make $(APP)
	mv c/$(APP) tmp/$(APP)
	make crom

# ModelSim
sim:
	make rom
	cd modelsim; make

bsim:
	cd modelsim; make batch

# MIPS simulator with yarisim
ysim:
	bin/yarisim --regdump tmp/$(APP).out

# Testing
test:
	testsuite/run.sh
.PHONY: test

# Compile Yamp and download
yamp:
	make synth
	make config

# configure the FPGA
config:
ifeq ($(USB),true)
	make config_usb
else
ifeq ($(XFPGA),true)
	make config_xilinx
else
	make config_byteblaster
endif
endif

synth:
	@echo $(QPROJ)
	for target in $(QPROJ); do \
		make qsyn -e QBT=$$target || exit; \
#		cd quartus/$$target && quartus_cpf -c yamp.sof ../../rbf/$$target.rbf; \
	done

#
#	Quartus build process
#		called by jopser, jopusb,...
#
qsyn:
	echo $(QBT)
	echo "building $(QBT)"
	-rm -rf quartus/$(QBT)/db
	-rm -f quartus/$(QBT)/yamp.sof
	-rm -f jbc/$(QBT).jbc
	-rm -f rbf/$(QBT).rbf
	quartus_map quartus/$(QBT)/yamp
	quartus_fit quartus/$(QBT)/yamp
	quartus_asm quartus/$(QBT)/yamp
	quartus_sta quartus/$(QBT)/yamp

config_byteblaster:
	cd quartus/$(QPROJ) && quartus_pgm -c $(BLASTER_TYPE) -m JTAG yamp.cdf

config_usb:
	cd rbf && ../$(USBRUNNER) $(QPROJ).rbf

# TODO: no Xilinx Makefiles available yet
config_xilinx:
	cd xilinx/$(XPROJ) && make config

clean:
	for ext in $(EXTENSIONS); do \
		find `ls` -name \*.$$ext -print -exec rm -r -f {} \; ; \
	done
	-find `ls` -name yamp.pof -print -exec rm -r -f {} \;
	-find `ls` -name db -print -exec rm -r -f {} \;
	-find `ls` -name incremental_db -print -exec rm -r -f {} \;
	-find `ls` -name yamp_description.txt -print -exec rm -r -f {} \;
	-rm -rf asm/generated
	-rm -f vhdl/*.vhd
	-rm -rf $(TOOLS)/dist
	-rm -rf $(PCTOOLS)/dist
	-rm -rf $(TARGET)/dist
	-rm -rf modelsim/work
	-rm -rf modelsim/transcript
