# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 1 us (1 MHz)
    clock = Clock(dut.clk, 1, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    # Set the input values you want to test
    # set the RTC_clk to 3600 Hz to have a sending each second instead of each hour
    RTC_clk = Clock(dut.ui_in[6], 277777778, units="ps")
    cocotb.start_soon(RTC_clk.start())

    # set the main clk to 1 MHz 
    clk = Clock(dut.ui_in[1], 1, units="us")
    cocotb.start_soon(clk.start())

    # set the reset signal
    reset = Clock(dut.ui_in[0], 900, units="ms")
    cocotb.start_soon(clk.start())

    
    #set values for channels 
    #channel 1 => 1 pulse 
    ch1 = Clock(dut.ui_in[2], 1, units="sec")
    cocotb.start_soon(ch1.start())
    #channel 2 => 2 pulses 
    ch2 = Clock(dut.ui_in[3], 500, units="ms")
    cocotb.start_soon(ch2.start())
    #channel 3 => 4 pulses 
    ch3 = Clock(dut.ui_in[4], 250, units="ms")
    cocotb.start_soon(ch3.start())
    #channel 4 => 8 pulses 
    ch4 = Clock(dut.ui_in[5], 125, units="ms")
    cocotb.start_soon(ch4.start())


    # Wait 
    await ClockCycles(dut.clk,1500000)



    # The following assersion is just an example of how to check the output values.
    # Change it to match the actual expected output of your module:
    # assert dut.uo_out.value == 50

    # Keep testing the module by changing the input values, waiting for
    # one or more clock cycles, and asserting the expected output values.
