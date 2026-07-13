#!/usr/bin/env bash
# Analyze the RTL and run every self-checking testbench with GHDL.
#
# Usage:
#   ./scripts/run_tests.sh          # run all testbenches
#   WAVES=1 ./scripts/run_tests.sh  # also dump .ghw waveforms to build/sim/

set -euo pipefail
cd "$(dirname "$0")/.."

WORKDIR=build/sim
mkdir -p "$WORKDIR"

ghdl -a --std=08 --workdir="$WORKDIR" \
    rtl/decoder_2to4.vhd \
    rtl/decoder_bcd.vhd \
    tb/tb_decoder_2to4.vhd \
    tb/tb_decoder_bcd.vhd

# Elaborate and run from inside the work directory so GHDL's build
# artifacts (objects, executables, waveforms) stay out of the source tree.
for tb in tb_decoder_2to4 tb_decoder_bcd; do
    echo "==> $tb"
    if [[ "${WAVES:-0}" == "1" ]]; then
        (cd "$WORKDIR" && ghdl --elab-run --std=08 --workdir=. "$tb" --wave="$tb.ghw")
    else
        (cd "$WORKDIR" && ghdl --elab-run --std=08 --workdir=. "$tb")
    fi
done

echo "All testbenches passed."
