`timescale 1ns / 1ps

module testbench();

logic clk_100MHz,reset,request;
logic pedestrian_red, pedestrian_green, pedestrian_blue;
logic car_red, car_green, car_blue;

top top_inst(.*);

initial begin
    clk_100MHz = 0;
    forever
        #5 clk_100MHz = ~clk_100MHz;
end

initial begin
    reset = 1;
    request = 0;
    #10 reset = 0;
    
    #100 request = 1;
    #100 request = 0;
end

endmodule
