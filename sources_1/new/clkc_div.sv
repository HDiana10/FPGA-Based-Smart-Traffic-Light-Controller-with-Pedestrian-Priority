`timescale 1ns / 1ps

module clk_div(
    input logic clk_100MHz,
    input logic reset,
    
    output logic clk_1Hz
    );

logic [31:0] count, countmax;
assign countmax = 50000000; // change with 1 to be able to see the simulation

always_ff @(posedge clk_100MHz, posedge reset) begin
    if(reset) begin
        clk_1Hz <= 0;
        count <= 0;
    end
    
    else begin
        if(count == countmax-1) begin
            count <= 0;
            clk_1Hz <= ~clk_1Hz;
        end
        else
            count <= count + 1;
    end
end 
endmodule
