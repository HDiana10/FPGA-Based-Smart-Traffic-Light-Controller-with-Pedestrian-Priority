`timescale 1ns / 1ps

module top(
    input logic clk_100MHz,
    input logic reset,
    input logic request,
    
    output logic pedestrian_red,
    output logic pedestrian_green,
    output logic pedestrian_blue,
    
    output logic car_red,
    output logic car_green,
    output logic car_blue
    );
    
logic clk_1Hz, counter_rst, out_or, out_ff;
logic [2:0] counter_max, counter;

assign out_or = out_ff | reset;

clk_div clk_div_inst(.*);

counter counter_inst(
    .clock(clk_1Hz),
    .reset(out_or),
    .count_max(counter_max),
    .count(counter)
);

ff ff_inst(
    .clock(clk_1Hz),
    .reset(reset),
    .counter_rst(counter_rst),
    .reset_ff(out_ff)
);

fsm fsm_inst(.*);


endmodule
