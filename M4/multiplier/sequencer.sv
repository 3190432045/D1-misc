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

 enum {IDLE, ADDING, SHIFTING, STOPPED} state;
 int count;

 always_ff @(posedge clock, negedge n_rst)
    begin: SEQ
     if(!n_rst)
        state <= IDLE;
     else
        unique case (state)
        IDLE: begin
        count <= 4;
          if (start)
            state <= ADDING;
        end

        ADDING: begin
            /*  should be = ? */
            count <= count - 1;
            state <= SHIFTING;
        end

        SHIFTING: begin
            if (count > 0)
                state <= ADDING;
            else
                state <= STOPPED;
        end

        STOPPED: begin
            count <= 4;
            if (start)
                state <= ADDING;
            else
                state <= STOPPED;
        end
        endcase
    end

 always_comb
    begin: COM
    add = '0;
    shift = '0;
    ready = '0;
    reset = '0;

    unique case (state)
        IDLE: begin
            reset = '1;
        end
        ADDING: begin
            if (Q0)
                add = '1;
        end
        SHIFTING: begin
            shift = '1;
        end
        STOPPED: begin
            ready = '1;
        end
    endcase
    end

//Last edited:20231027

endmodule



