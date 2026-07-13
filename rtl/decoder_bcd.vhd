-- decoder_bcd: BCD-to-decimal (4-to-10) decoder with active-high outputs
-- and an active-high enable.
--
-- When EN = '1' and B encodes a valid BCD digit (0-9), the matching output
-- Y(i) is driven high (one-hot). When EN = '0', or when B holds an invalid
-- code (10-15), all outputs stay low.

library ieee;
use ieee.std_logic_1164.all;

entity decoder_bcd is
    port (
        EN : in  std_logic;                     -- active-high enable
        B  : in  std_logic_vector(3 downto 0);  -- BCD digit input
        Y  : out std_logic_vector(9 downto 0)   -- one-hot decimal outputs
    );
end entity decoder_bcd;

architecture rtl of decoder_bcd is
begin
    -- One product term per decimal output: Y(i) = EN AND minterm_i(B).
    -- Minterms 10-15 are deliberately not decoded, so invalid BCD codes
    -- leave every output low instead of aliasing onto a valid digit.
    Y(0) <= EN and (not B(3)) and (not B(2)) and (not B(1)) and (not B(0));
    Y(1) <= EN and (not B(3)) and (not B(2)) and (not B(1)) and B(0);
    Y(2) <= EN and (not B(3)) and (not B(2)) and B(1) and (not B(0));
    Y(3) <= EN and (not B(3)) and (not B(2)) and B(1) and B(0);
    Y(4) <= EN and (not B(3)) and B(2) and (not B(1)) and (not B(0));
    Y(5) <= EN and (not B(3)) and B(2) and (not B(1)) and B(0);
    Y(6) <= EN and (not B(3)) and B(2) and B(1) and (not B(0));
    Y(7) <= EN and (not B(3)) and B(2) and B(1) and B(0);
    Y(8) <= EN and B(3) and (not B(2)) and (not B(1)) and (not B(0));
    Y(9) <= EN and B(3) and (not B(2)) and (not B(1)) and B(0);
end architecture rtl;
