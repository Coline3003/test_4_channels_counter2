module mux_5to1(input wire [4:0] data,
                input wire [2:0] select,
           output reg data_out
          );


  always @(*) begin
    casez (select)  
      3'b000 : data_out = data[0]; 
      3'b001 : data_out = data[1]; 
      3'b010 : data_out = data[2];
      3'b011 : data_out = data[3];
      3'b100 : data_out = data[4];
      default :  data_out = 1'b0;
     endcase  
   end  
  
endmodule
