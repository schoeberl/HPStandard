#
#	Makefile for ModelSim simulation
#


YAMPDIR=../vhdl
#OPTIONS= -2008 -quiet -check_synthesis -lint -pedanticerrors
OPTIONS= -2008 -quiet

ifeq ($(WINDIR),)
	WINE=wine
	S=:
else
	WINE=
	S=\;
endif

all: clean base
	$(WINE) vcom $(OPTIONS) $(YAMPDIR)/simulation/tb_yamp.vhd
	$(WINE) vsim -do sim.do tb_yamp

batch: clean base
	$(WINE) vcom $(OPTIONS) $(YAMPDIR)/simulation/tb_yamp.vhd
	$(WINE) vsim -c -do batch.do tb_yamp

base:
	$(WINE) vlib work
	$(WINE) vcom $(OPTIONS) $(YAMPDIR)/core/yamp_types.vhd
	$(WINE) vcom $(OPTIONS) $(YAMPDIR)/generated/yamp_rom.vhd
	$(WINE) vcom $(OPTIONS) $(YAMPDIR)/core/yamp_rf.vhd
	$(WINE) vcom $(OPTIONS) $(YAMPDIR)/core/yamp_fetch.vhd
	$(WINE) vcom $(OPTIONS) $(YAMPDIR)/core/yamp_decode.vhd
	$(WINE) vcom $(OPTIONS) $(YAMPDIR)/core/yamp_execute.vhd
	$(WINE) vcom $(OPTIONS) $(YAMPDIR)/core/yamp_memory.vhd
	$(WINE) vcom $(OPTIONS) $(YAMPDIR)/core/yamp_wback.vhd
	$(WINE) vcom $(OPTIONS) $(YAMPDIR)/core/yamp.vhd
clean:
	-rm *.wlf
	-rm transcript
	-rm -r work

