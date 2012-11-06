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
-- Instruction decode stage.
--
-- Author: Martin Schoeberl (martin@jopdesign.com)
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.yamp_types.all;

entity yamp_decode is
	port(
		clk   : in  std_logic;
		reset : in  std_logic;
		ena   : in  std_logic;
		din   : in  fedec_type;
		dout  : out decex_type);
end entity yamp_decode;

architecture rtl of yamp_decode is
	signal fedec_reg : fedec_type;
	signal decout    : decex_type;

begin
	-- Pipeline register, with an enable for stalling
	-- Reset to an inactive value (nop instruction)
	process(clk, reset)
	begin
		if reset = '1' then
			fedec_reg.instr <= (others => '0');
		elsif rising_edge(clk) then
			if ena = '1' then
				fedec_reg <= din;
			end if;
		end if;
	end process;

	-- register file read is from unregistered instruction
	rf : entity work.yamp_rf port map(
			clk, reset,
			din.instr(25 downto 21), din.instr(20 downto 16),
			decout.rsval, decout.rtval,
			"11111",                    -- write address
			din.instr,                  -- shall be write data
			'0'
		);

	decout.rs    <= fedec_reg.instr(25 downto 21);
	decout.rt    <= fedec_reg.instr(20 downto 16);
	decout.rd    <= fedec_reg.instr(15 downto 11);
	decout.instr <= fedec_reg.instr;
	-- that's dependent on the instruction
	decout.rd_ena <= '1';

	dout <= decout;

end;