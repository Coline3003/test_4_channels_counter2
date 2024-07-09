
/*
A clock divider in Verilog, using the cascading
flip-flop method.
*/

module channel_counter(input impulse, input reset, output reg [11:0] data, output reg ovf
                       );

    
//-- Output is 26-bit bus, initialized at 0




//-- Sensitive to rising edge
  always @(posedge reset or posedge impulse) begin
  //-- Incrementar el registro
    if(reset == 1) begin
	data <= 12'b0;
	ovf <= 0;	
    end
    else if(impulse == 1) begin
      data <= data + 1;
      if(data == 4095) begin
	ovf <= 1;
	end
    end
  
  end
  
endmodule
