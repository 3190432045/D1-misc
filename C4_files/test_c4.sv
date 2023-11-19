/////////////////////////////////////////////////////////////////////
// Design unit: test_c4
//            :
// File name  : test_c4.sv
//            :
// Description: Testbench for for C4 Lab exercise
//            :
// Limitations: None
//            :
// System     : SystemVerilog IEEE 1800-2005
//            :
// Author     : Mark Zwolinski
//            : School of Electronics and Computer Science
//            : University of Southampton
//            : Southampton SO17 1BJ, UK
//            : mz@ecs.soton.ac.uk
//
// Revision   : Version 1.0 28/08/17
//            : Version 2.0 04/11/20
//
/////////////////////////////////////////////////////////////////////


module test_c4;

timeunit 1ns;
timeprecision 100ps;

logic s, t, n, sdo;
logic n_clk, rst, a, c, m ,sdi;

c4 c4 (.*);

initial
  begin
  n_clk = 0;
  #20;
  forever #10 n_clk = ~n_clk;
  end

initial

/*
  begin
  rst = 1;
  a = 0;
  #10 rst = 0;
  #10 rst = 1;
  #40 a = 1;
  #60 a = 0;
  #20 a = 1;
  #20 a = 0;
  #40 a = 1;
  #20 a = 0;
  #20 a = 1;
  #20 $finish;
  end
*/
/*
begin
        rst = 1;
		a = 0;
		c = 1;
        #20 rst = 0;
		#20 rst = 1;  //reset to AA


        #20 a = 1;	// AA to AB
        #20 a = 0;  // AB to AC

        #20 a = 0;	// AC back to AA
        #20 a = 1;  // AA to AB


        #20 a = 0; 	// AB to AC


        #20 a = 1;	// AC back to AA

        #20 a = 1;	// AA to AB

        #20 a = 1;  // AB to AD
        #20 a = 1;  // AD back to AD
		#20 a = 0;	// AD to AA

        #20 $finish;
    end
*/

// 2.4

    begin
        a = 0;
        c = 0;
        m = 0;
        #10 rst = 0;
        #10 rst = 1;
        #100 m = 1;
        sdi = 1;
        #20 sdi = 0;
        #20 sdi = 1;
        #20 sdi = 1;
        #20 sdi = 1;
        #20 sdi = 0;
        #20 sdi = 1;
        #20 sdi = 0;
        #20 sdi = 0;
        #20 sdi = 1;
    end
/*
begin

  rst = 1;
  a = 0;
  #10 rst = 0;
  #10 rst = 1;
  #5
  if ({s,t} == 2'b00)
      $display("00/0 -> 00\t success\n");
  else
      $display("00/0 -> 00\t fail\n");

  #5
  rst = 1;
  a = 0;
  #10 rst = 0;
  #10 rst = 1;
  a = 1;
  #5
  if ({s,t} == 2'b01)
      $display("00/1 -> 01\t success\n");
  else
      $display("00/1 -> 01\t fail\n");

end
*/

// assertions

//default clocking clock_block
//@(negedge n_clk);
//endclocking

property StateChange_000_00;
@(negedge n_clk) ({s,t,a} == 3'b000) |-> ({s,t} == 2'b00);
endproperty

property StateChange_001_01;
@(negedge n_clk) ({s,t,a} == 3'b001) |-> ({s,t} == 2'b01);
endproperty

property StateChange_010_11;
@(negedge n_clk) ({s,t,a} == 3'b010) |-> ({s,t} == 2'b11);
endproperty

property StateChange_011_10;
@(negedge n_clk) ({s,t,a} == 3'b011) |-> ({s,t} == 2'b10);
endproperty

property StateChange_110_00;
@(negedge n_clk) ({s,t,a} == 3'b110) |-> ({s,t} == 2'b00);
endproperty

property StateChange_111_00;
@(negedge n_clk) ({s,t,a} == 3'b111) |-> ({s,t} == 2'b00);
endproperty

property StateChange_100_00;
@(negedge n_clk) ({s,t,a} == 3'b100) |-> ({s,t} == 2'b00);
endproperty

property StateChange_101_10;
@(negedge n_clk) ({s,t,a} == 3'b101) |-> ({s,t} == 2'b10);
endproperty

StateChange000_00 : assert property(StateChange_000_00)
      $display("00/0 -> 00\t success\n");
  else
      $display("00/0 -> 00\t fail\n");

StateChange001_01 : assert property(StateChange_001_01)
      $display("00/1 -> 01\t success\n");
  else
      $display("00/1 -> 01\t fail\n");

StateChange010_11 : assert property(StateChange_010_11)
      $display("01/0 -> 11\t success\n");
  else
      $display("01/0 -> 11\t fail\n");

StateChange011_10 : assert property(StateChange_011_10)
      $display("01/1 -> 10\t success\n");
  else
      $display("01/1 -> 10\t fail\n");

StateChange110_00 : assert property(StateChange_110_00)
      $display("11/0 -> 00\t success\n");
  else
      $display("11/0 -> 00\t fail\n");

StateChange111_00 : assert property(StateChange_111_00)
      $display("11/1 -> 00\t success\n");
  else
      $display("11/1 -> 00\t fail\n");

StateChange100_00 : assert property(StateChange_100_00)
      $display("10/0 -> 00\t success\n");
  else
      $display("10/0 -> 00\t fail\n");

StateChange101_10 : assert property(StateChange_101_10)
      $display("10/1 -> 10\t success\n");
  else
      $display("10/1 -> 10\t fail\n");

endmodule
