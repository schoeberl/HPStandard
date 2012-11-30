YAMP
====

Yet Another MIPS Processor

A design of the seminal 5 stage pipeline that shall be easy to read,
clean VHDL code. Mainly an educational design. Might contain some FPGA
target optimizations.

Also a test case how long it takes to develop a MIPS pipeline, assuming
reasonable VHDL knowledge. Furthermore, we can leverage some work from
JOP, Leros, and Patmos.

Getting started
---------------

Simply clone from GitHub with:

git clone git://github.com/schoeberl/yamp.git

or download the ZIP file from GitHub at:

https://github.com/schoeberl/yamp/archive/master.zip

A plain 'make' will:

1) Download additional tools (binutils, YARI simulator)
2) Build the tools
3) Assemble the add.s test program
4) Compile YAMP
5) Start ModelSim with the simulation

To run the YAMP simulation against the MIPS SW emulator yarisim in co-simulation do:

make test

Hardware is synthesized with

make yamp

That's it for now!

Prerequisites
-------------

Some tools are needed

* make
* Java (JDK)
* a C compiler
* cmake and boost (recent versions)
* libelf
* ModelSim
* (Quartus)
* SDL (sdllib on Mac ports)


Timing logging
--------------

5.11.2012: 2h45' Setup the project, create first VHDL files, ModelSim simulation,
                 a Quartus project
		 
6.11.2012: 1h00' Structure the records for registers, search for MIPS tools

7.11.2012: 5h30' Build binutils, ELF to VHDL conversion, fetch from ROM,
                 first two instructions, add the YARI/MIPS simulator for co-simulation

12.11.2012: 2h00' Add top level plus PLL for fmax tests, tests for forwarding

13.11.2012: 2h15' Collect minimal set of instructions, setup co-simulation, forwarding

15.11.2012: 1h30' Some more ALU instructions

23.11.2012: 0h45' Start a LaTeX document

29.11.2012: 1h15' Some more ALU functions (sub/u and nor), fix in yarisim