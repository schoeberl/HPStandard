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
		clk    : in  std_logic;
		reset  : in  std_logic;
		ena    : in  std_logic;
		din    : in  fedec_type;
		dinmem : in  memwb_type;
		dout   : out decex_type);
end entity yamp_decode;

architecture rtl of yamp_decode is
	signal fedec_reg : fedec_type;
	signal decout    : decex_type;

	signal opcode, funct : std_logic_vector(5 downto 0);

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
			decout.rs.val, decout.rt.val,
			dinmem.rdest.reg.regnr,     -- write address
			dinmem.rdest.reg.val,       -- write data
			dinmem.rdest.wrena
		);

	decout.rs.regnr <= fedec_reg.instr(25 downto 21);
	decout.rt.regnr <= fedec_reg.instr(20 downto 16);
	decout.sa       <= fedec_reg.instr(10 downto 6);

	funct  <= fedec_reg.instr(5 downto 0);
	opcode <= fedec_reg.instr(31 downto 26);

	decout.instr <= fedec_reg.instr;

	process(all)
	begin
		-- some useful defaults
		decout.sel_imm              <= '0';
		decout.sel_add              <= '0';
		decout.sel_ldimm            <= '0';
		decout.sel_or               <= '0';
		decout.sel_and              <= '0';
		-- TODO: sign extend when needed
		decout.immval(15 downto 0)  <= fedec_reg.instr(15 downto 0);
		decout.immval(31 downto 16) <= (others => '0');

		-- default is R type
		decout.rdest.regnr <= fedec_reg.instr(15 downto 11);
		decout.rdest.wrena <= '0';

		case opcode is
			when "000000" =>            -- R format (?)
				case funct is
					when "000000" =>    -- ?

					when "100000" =>    -- add
						decout.sel_add     <= '1';
						decout.rdest.wrena <= '1';
					when "100001" =>    -- addu
						decout.sel_add     <= '1';
						decout.rdest.wrena <= '1';
					when "100100" =>    -- and
						decout.sel_and     <= '1';
						decout.rdest.wrena <= '1';
					when "100101" =>    -- or
						decout.sel_or      <= '1';
						decout.rdest.wrena <= '1';
					when others =>
						null;
				end case;
			when "001111" =>            -- lui
				decout.sel_imm              <= '1';
				decout.sel_ldimm            <= '1';
				decout.rdest.wrena          <= '1';
				decout.rdest.regnr          <= fedec_reg.instr(20 downto 16);
				decout.immval(15 downto 0)  <= (others => '0');
				decout.immval(31 downto 16) <= fedec_reg.instr(15 downto 0);
			when "001000" =>            -- addi
				decout.sel_imm              <= '1';
				decout.sel_add              <= '1';
				decout.rdest.wrena          <= '1';
				decout.rdest.regnr          <= fedec_reg.instr(20 downto 16);
				decout.immval(31 downto 16) <= (others => fedec_reg.instr(15));
			when "001001" =>            -- addiu
				decout.sel_imm              <= '1';
				decout.sel_add              <= '1';
				decout.rdest.wrena          <= '1';
				decout.rdest.regnr          <= fedec_reg.instr(20 downto 16);
				decout.immval(31 downto 16) <= (others => fedec_reg.instr(15));
			when "001100" =>            -- andi
				decout.sel_imm     <= '1';
				decout.sel_and      <= '1';
				decout.rdest.wrena <= '1';
				decout.rdest.regnr <= fedec_reg.instr(20 downto 16);
			when "001101" =>            -- ori
				decout.sel_imm     <= '1';
				decout.sel_or      <= '1';
				decout.rdest.wrena <= '1';
				decout.rdest.regnr <= fedec_reg.instr(20 downto 16);
			when others =>
				null;
		end case;

		-- Is this good style to asign the value in the process and also read it?
		-- Disable wrena when rdest.regnr == 0
		if decout.rdest.regnr = "00000" then
			decout.rdest.wrena <= '0';
		end if;
	end process;

	dout <= decout;

end;