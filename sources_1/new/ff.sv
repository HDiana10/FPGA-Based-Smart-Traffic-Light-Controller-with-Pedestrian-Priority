`timescale 1ns / 1ps

module ff(
    input logic clock,
    input logic reset,
    input logic counter_rst,
    
    output logic reset_ff
    );

always_ff @(posedge clock, posedge reset) begin
    if(reset)
        reset_ff <= 0;
    else
        reset_ff <= counter_rst;

end

endmodule
