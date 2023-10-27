/////////////////////////////////////////////////////////////////////
// Design unit: sequencer
//            :
// File name  : sequencer.sv
//            :
// Description: Code for M4 Lab exercise
//            : Outline code for sequencer
//            :
// Limitations: None
//            :
// System     : SystemVerilog IEEE 1800-2005
//            :
// Author     :
//            : School of Electronics and Computer Science
//            : University of Southampton
//            : Southampton SO17 1BJ, UK
//            :
//
// Revision   : Version 1.0
/////////////////////////////////////////////////////////////////////

module sequencer (input logic start, clock, Q0, n_rst,
 output logic add, shift, ready, reset);

 enum {IDLE, ADDING, SHIFTING, STOPPED} present_state, next_state;

 always_ff @(posedge clock, negedge n_rst)
    begin: SEQ
     if(!n_rst)
        present_state <= IDLE;
    else
        present_state <= next_state;
    end

 always_comb
    begin: COM
    add = '0;
    shift = '0;
    ready = '0;
    reset = '0;

    unique_case (present_state)
        IDLE: begin

        end

        ADDING: begin

        end

        SHIFTING: begin

        end

        STOPPED: begin

        end
    endcase
    end

//Last edited:20231027

endmodule



