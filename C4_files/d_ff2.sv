/////////////////////////////////////////////////////////////////////
// Design unit: d_ff2
//            :
// File name  : d_ff2.sv
//            :
// Description:
//            :
// Limitations: None
//            :
// System     : SystemVerilog IEEE 1800-2005
//            :
// Author     :
//            :
//            :
//            :
//            :
//
// Revision   :
//            :
//
/////////////////////////////////////////////////////////////////////


module d_ff2 (output logic q, input logic clk, rst, enable, d);

always_ff @(posedge clk, negedge rst)
  if (~rst)
    begin
    q <= 1'b0;
    end
  else if(enable)
    begin
    q <= d;
    end

endmodule
