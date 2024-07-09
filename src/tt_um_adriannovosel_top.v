//light up the leds according to a counter to cycle through every one

module tt_um_adriannovosel_top(input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
                              );

    top top1(.reset(ui_in[0]), .clk(ui_in[1]), .ch1(ui_in[2]), .ch2(ui_in[3]), .ch3(ui_in[4]), .ch4(ui_in[5]), .RTC(ui_in[6]), 
             .serial_out(uo_out[0]), .ovf_global(uo_out[1]), .ovf_RTC_out(uo_out[2]), .a0_out(uo_out[3]), .a1_out(uo_out[4]), 
             .a2_out(uo_out[5]), .SL_out(uo_out[6]), .ovf_ch_out(uo_out[7]));
   assign uio_out = 8'b0;
    assign uio_oe = 8'b0;
endmodule // top
