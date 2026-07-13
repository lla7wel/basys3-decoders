-- Self-checking testbench for decoder_2to4.
-- Exhaustively applies all 4 select values and checks that exactly the
-- addressed output is low (one-cold) while the others stay high.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_decoder_2to4 is
end entity tb_decoder_2to4;

architecture sim of tb_decoder_2to4 is
    signal A : std_logic_vector(1 downto 0);
    signal X : std_logic_vector(3 downto 0);
begin

    dut : entity work.decoder_2to4
        port map (
            A => A,
            X => X
        );

    stimulus : process
        variable expected : std_logic_vector(3 downto 0);
        variable errors   : natural := 0;
    begin
        for i in 0 to 3 loop
            A <= std_logic_vector(to_unsigned(i, 2));
            wait for 10 ns;

            expected := (others => '1');
            expected(i) := '0';

            if X /= expected then
                report "FAIL: A=" & integer'image(i)
                    & " expected X=" & integer'image(to_integer(unsigned(expected)))
                    & " got X=" & integer'image(to_integer(unsigned(X)))
                    severity error;
                errors := errors + 1;
            end if;
        end loop;

        if errors = 0 then
            report "tb_decoder_2to4: PASS (4/4 vectors)" severity note;
        else
            report "tb_decoder_2to4: FAIL (" & integer'image(errors)
                & " of 4 vectors)" severity failure;
        end if;
        wait;
    end process;

end architecture sim;
