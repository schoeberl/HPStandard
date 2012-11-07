-- 
-- Copyright Technical University of Denmark. All rights reserved.
-- This file is part of the Yamp MIPS processor.
-- 
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:
-- 
--    1. Redistributions of source code must retain the above copyright notice,
--       this list of conditions and the following disclaimer.
-- 
--    2. Redistributions in binary form must reproduce the above copyright
--       notice, this list of conditions and the following disclaimer in the
--       documentation and/or other materials provided with the distribution.
-- 
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ``AS IS'' AND ANY EXPRESS
-- OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
-- OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
-- NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
-- DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
-- (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
-- LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
-- ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
-- THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-- 
-- The views and conclusions contained in the software and documentation are
-- those of the authors and should not be interpreted as representing official
-- policies, either expressed or implied, of the copyright holder.
-- 


--------------------------------------------------------------------------------
-- Instruction fetch stage.
--
-- Author: Martin Schoeberl (martin@jopdesign.com)
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.yamp_types.all;

entity yamp_fetch is
	port(
		clk   : in  std_logic;
		reset : in  std_logic;
		ena   : in  std_logic;
		dout  : out fedec_type);
end entity yamp_fetch;

architecture rtl of yamp_fetch is
	constant rom_addr_size : integer := 10;
	signal address         : std_logic_vector(rom_addr_size - 1 downto 0);

	signal feout : fedec_type;

	-- we count in 32-bit words
	signal pc, pc_next : unsigned(29 downto 0);

begin
	process(clk, reset)
	begin
		if reset = '1' then
			-- Start at -1 to execute the first instruction
			pc <= (others => '1');
		elsif rising_edge(clk) then
			if ena = '1' then
				pc <= pc_next;
			end if;
			-- no disable of this register as it is in the on-chip memory
			address <= std_logic_vector(pc_next(rom_addr_size - 1 downto 0));
		end if;
	end process;

	pc_next <= pc + 1;

	rom : entity work.yamp_rom
		port map(
			address => address,
			q       => feout.instr
		);

	dout <= feout;

end;