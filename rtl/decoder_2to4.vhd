-- decoder_2to4: 2-to-4 binary decoder with active-low outputs.
--
-- Exactly one output is driven low ("one-cold") for each value of the
-- 2-bit select input; the remaining outputs stay high.
--
--   A = "00"  ->  X = "1110"
--   A = "01"  ->  X = "1101"
--   A = "10"  ->  X = "1011"
--   A = "11"  ->  X = "0111"

library ieee;
use ieee.std_logic_1164.all;

entity decoder_2to4 is
    port (
        A : in  std_logic_vector(1 downto 0);  -- binary select input
        X : out std_logic_vector(3 downto 0)   -- active-low decoded outputs
    );
end entity decoder_2to4;

architecture rtl of decoder_2to4 is
begin
    -- Each active-low output is the complemented minterm of A,
    -- written in De Morgan (OR) form.
    X(0) <= A(0) or A(1);
    X(1) <= (not A(0)) or A(1);
    X(2) <= A(0) or (not A(1));
    X(3) <= not (A(0) and A(1));
end architecture rtl;
