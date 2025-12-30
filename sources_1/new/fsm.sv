`timescale 1ns / 1ps

module fsm(
    input logic clk_1Hz,
    input logic reset,
    input logic request,
    input logic [2:0] counter, 
    
    output logic counter_rst,
    output logic [2:0]counter_max,
    output logic pedestrian_red,
    output logic pedestrian_green,
    output logic pedestrian_blue,
    output logic car_red,
    output logic car_green,
    output logic car_blue
    );

logic [1:0] state, next_state;
localparam Q0 = 2'b00;
localparam Q1 = 2'b01;
localparam Q2 = 2'b10;
localparam Q3 = 2'b11;

// === Sequential block for the state register ===
always_ff @(posedge clk_1Hz, posedge reset) begin
    if(reset) begin
        state <= Q0;
    end
    else begin
        state <= next_state;
    end
    
end

// === Combinational block for next_state logic ===
always_comb begin
    next_state = state;
    
    case(state)
        Q0: begin
            if(counter == counter_max)
                next_state = Q1;
        end
        Q1: begin
            if(request)
                next_state = Q2;
            else if(counter == counter_max)
                next_state = Q3;
        end
        Q2: begin
            if(request == 0)
                next_state = Q1;
            else if(counter == counter_max)
                next_state = Q3;
        end
        Q3: begin
            if(counter == counter_max)
                next_state = Q0;
        end
        default:
            next_state = Q0;
    endcase
end

// === Condition for counter reset ===
assign counter_rst = (state != next_state);


// === Combinational block for outputs
always_comb begin

    case(state)
        Q0: begin
            car_red = 1;
            car_blue = 0;
            car_green = 0;
            counter_max = 7;
            pedestrian_green = 1;
            pedestrian_red = 0;
            pedestrian_blue = 0;
        end
        
        Q1: begin
            car_green = 1;
            car_red = 0;
            car_blue = 0;
            
            pedestrian_green = 0;
            pedestrian_blue = 0;
            pedestrian_red = 1;
            
            counter_max = 7;
        end
        
        Q2: begin
            car_green = 1;
            car_red = 0;
            car_blue = 0;
            
            pedestrian_green = 0;
            pedestrian_blue = 0;
            pedestrian_red = 1;
            
            counter_max = 3;
        end
        
        Q3: begin
            car_green = 1;
            car_red = 1;
            car_blue = 0;
            
            pedestrian_green = 0;
            pedestrian_blue = 0;
            pedestrian_red = 1;
            
            counter_max = 3;
        end
    endcase
end

endmodule
