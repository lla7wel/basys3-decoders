-- Self-checking testbench for decoder_bcd.
-- Exhaustively applies all 32 input combinations (EN x B[3:0]) and checks:
--   EN = '0'            -> all outputs low, for every input code
--   EN = '1', B in 0..9 -> one-hot output on Y(B)
--   EN = '1', B in 10..15 (invalid BCD) -> all outputs low

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_decoder_bcd is
end entity tb_decoder_bcd;

architecture sim of tb_decoder_bcd is
    signal EN : std_logic;
    signal B  : std_logic_vector(3 downto 0);
    signal Y  : std_logic_vector(9 downto 0);
begin

    dut : entity work.decoder_bcd
        port map (
            EN => EN,
            B  => B,
            Y  => Y
        );

    stimulus : process
        variable expected : std_logic_vector(9 downto 0);
        variable errors   : natural := 0;
    begin
        for en_val in 0 to 1 loop
            if en_val = 0 then
                EN <= '0';
            else
                EN <= '1';
            end if;

            for i in 0 to 15 loop
                B <= std_logic_vector(to_unsigned(i, 4));
                wait for 10 ns;

                expected := (others => '0');
                if en_val = 1 and i <= 9 then
                    expected(i) := '1';
                end if;

                if Y /= expected then
                    report "FAIL: EN=" & integer'image(en_val)
                        & " B=" & integer'image(i)
                        & " expected Y=" & integer'image(to_integer(unsigned(expected)))
                        & " got Y=" & integer'image(to_integer(unsigned(Y)))
                        severity error;
                    errors := errors + 1;
                end if;
            end loop;
        end loop;

        if errors = 0 then
            report "tb_decoder_bcd: PASS (32/32 vectors)" severity note;
        else
            report "tb_decoder_bcd: FAIL (" & integer'image(errors)
                & " of 32 vectors)" severity failure;
        end if;
        wait;
    end process;

end architecture sim;
