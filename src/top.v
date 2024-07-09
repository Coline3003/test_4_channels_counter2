//`include "channel_counter.v"
//`include "FSM.v"
//`include "time_counter.v"
//`include "PISO_register.v"
//`include "mux_5to1.v"
//`include "ovf_detect.v"

module top(input clk, ch1, ch2, ch3, ch4, RTC, reset,
           output wire serial_out, ovf_global, ovf_RTC_out, a0_out, a1_out, a2_out, SL_out, ovf_ch_out
           );
  wire[11:0] ch1_data, ch2_data, ch3_data, ch4_data, RTC_data;
  wire ovf1, ovf2, ovf3, ovf4, ovf_RTC;
  wire[4:0] mux0_data,mux1_data,mux2_data,mux3_data,mux4_data,mux5_data,mux6_data,mux7_data,mux8_data,mux9_data,mux10_data,mux11_data;
  //wire[2:0] mux0_address,mux1_address,mux2_address,mux3_address,mux4_address,mux5_address,mux6_address,mux7_address,mux8_address,mux9_address,mux10_address,mux11_address;
  wire mux0_out,mux1_out,mux2_out,mux3_out,mux4_out,mux5_out,mux6_out,mux7_out,mux8_out,mux9_out,mux10_out,mux11_out;
  wire a0, a1, a2, SL;//, out_rst;
  //wire reset;
  wire ch1w,ch2w,ch3w,ch4w;
  

  assign ovf_RTC_out = ovf_RTC;
  assign ovf_ch_out = ovf1||ovf2||ovf3||ovf4;
  assign a0_out = a0;
  assign a1_out = a1;
  assign a2_out = a2;
  assign SL_out = SL;
  
  assign ovf_global = ovf1||ovf2||ovf3||ovf4||ovf_RTC;

/*SB_IO_OD #(
  .PIN_TYPE(6'b00001),
  .NEG_TRIGGER(1'b0)
) pin_in_driver1 (
  .PACKAGEPIN(ch1),
  .DIN0(ch1w)
);

SB_IO_OD #(
  .PIN_TYPE(6'b00001),
  .NEG_TRIGGER(1'b0)
) pin_in_driver2 (
  .PACKAGEPIN(ch2),
  .DIN0(ch2w)
);
SB_IO_OD #(
  .PIN_TYPE(6'b00001),
  .NEG_TRIGGER(1'b0)
) pin_in_driver3 (
  .PACKAGEPIN(ch3),
  .DIN0(ch3w)
);*/
  
  channel_counter ch1c(.impulse(ch1), .reset(reset||out_rst), 
                        .data(ch1_data), .ovf(ovf1))/* synthesis syn_noprune=1 */;
  channel_counter ch2c(.impulse(ch2), .reset(reset||out_rst), 
                        .data(ch2_data), .ovf(ovf2))/* synthesis syn_noprune=1 */;
  channel_counter ch3c(.impulse(ch3), .reset(reset||out_rst), 
                        .data(ch3_data), .ovf(ovf3))/* synthesis syn_noprune=1 */;
  channel_counter ch4c(.impulse(ch4), .reset(reset||out_rst), 
                        .data(ch4_data), .ovf(ovf4))/* synthesis syn_noprune=1 */;

  
  
  

  time_counter time_c(.clk(RTC), .reset(reset||out_rst),
                        .min(RTC_data[11:6]),.sec(RTC_data[5:0]),.ovf(ovf_RTC))/* synthesis syn_noprune=1 */;
  
  assign mux0_data = {RTC_data[0],ch4_data[0],ch3_data[0],ch2_data[0],ch1_data[0]};
  assign mux1_data = {RTC_data[1],ch4_data[1],ch3_data[1],ch2_data[1],ch1_data[1]};
  assign mux2_data = {RTC_data[2],ch4_data[2],ch3_data[2],ch2_data[2],ch1_data[2]};
  assign mux3_data = {RTC_data[3],ch4_data[3],ch3_data[3],ch2_data[3],ch1_data[3]};
  assign mux4_data = {RTC_data[4],ch4_data[4],ch3_data[4],ch2_data[4],ch1_data[4]};
  assign mux5_data = {RTC_data[5],ch4_data[5],ch3_data[5],ch2_data[5],ch1_data[5]};
  assign mux6_data = {RTC_data[6],ch4_data[6],ch3_data[6],ch2_data[6],ch1_data[6]};
  assign mux7_data = {RTC_data[7],ch4_data[7],ch3_data[7],ch2_data[7],ch1_data[7]};
  assign mux8_data = {RTC_data[8],ch4_data[8],ch3_data[8],ch2_data[8],ch1_data[8]};
  assign mux9_data = {RTC_data[9],ch4_data[9],ch3_data[9],ch2_data[9],ch1_data[9]};
  assign mux10_data = {RTC_data[10],ch4_data[10],ch3_data[10],ch2_data[10],ch1_data[10]};
  assign mux11_data = {RTC_data[11],ch4_data[11],ch3_data[11],ch2_data[11],ch1_data[11]};
  
  
  
  FSM FSM1(.clk(clk),.reset(reset),.ovf_RTC(ovf_RTC),.ovf(ovf1||ovf2||ovf3||ovf4),.a0(a0),.a1(a1),.a2(a2),.SL(SL),.out_rst(out_rst))/* synthesis syn_noprune=1 */;
  
  mux_5to1 mux0(.data(mux0_data), .select({a2,a1,a0}), .data_out(mux0_out));               
  mux_5to1 mux1(.data(mux1_data), .select({a2,a1,a0}), .data_out(mux1_out));               
  mux_5to1 mux2(.data(mux2_data), .select({a2,a1,a0}), .data_out(mux2_out));               
  mux_5to1 mux3(.data(mux3_data), .select({a2,a1,a0}), .data_out(mux3_out));               
  mux_5to1 mux4(.data(mux4_data), .select({a2,a1,a0}), .data_out(mux4_out));               
  mux_5to1 mux5(.data(mux5_data), .select({a2,a1,a0}), .data_out(mux5_out));               
  mux_5to1 mux6(.data(mux6_data), .select({a2,a1,a0}), .data_out(mux6_out));               
  mux_5to1 mux7(.data(mux7_data), .select({a2,a1,a0}), .data_out(mux7_out));               
  mux_5to1 mux8(.data(mux8_data), .select({a2,a1,a0}), .data_out(mux8_out));               
  mux_5to1 mux9(.data(mux9_data), .select({a2,a1,a0}), .data_out(mux9_out));               
  mux_5to1 mux10(.data(mux10_data), .select({a2,a1,a0}), .data_out(mux10_out));               
  mux_5to1 mux11(.data(mux11_data), .select({a2,a1,a0}), .data_out(mux11_out));
  
  PISO_register PISO_register1(.clk(clk),.parallel_in({mux11_out,mux10_out,mux9_out,mux8_out,mux7_out,mux6_out,mux5_out,mux4_out,mux3_out,mux2_out,mux1_out,mux0_out}),.SL(SL),.serial_out(serial_out));

 
  

  
endmodule
