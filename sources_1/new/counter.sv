`timescale 1ns / 1ps

module counter(
    input logic clock,
    input logic reset,
    input logic [2:0] count_max,
    output logic [2:0] count
    );
    
    
always_ff @(posedge clock, posedge reset) begin
    if(reset)
        count <= 0;
    else begin
        if(count == count_max)
            count <= 0;
        else
            count <= count + 1;
    end
end
endmodule
