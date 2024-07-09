module PISO_register(
  input wire clk,
  input wire [11:0] parallel_in,
  input wire SL, // 1 => load, 0 => shift
  output reg serial_out
);

  reg [11:0] register;

  always @(posedge clk) begin
    if(SL==1)
      register[11:0] <= parallel_in[11:0];
    else if (SL==0) begin
      serial_out <= register[0]; // Output the least significant bit
      register <= register >>> 1;
    end
  end
  

endmodule
