// ELEX 7660 Lab 2 
// Author: Nicholas Scott AKA "White Cheddar" - SN: A01255181
// Date: Jan 23rd, 2024
// Instructor: Sweet Bobby T

module encoder (input logic a, b, clk,
                output logic cw, ccw); 
    
    logic [1:0] state;  // State of the encoder output
    logic [1:0] previous_state; 

    always_ff @(posedge clk) begin 

        state <= {a,b};
        previous_state <= state; 

        if (((state == 'b10) && (previous_state == 'b00)) || 
            ((state == 'b11) && (previous_state == 'b10)) || 
            ((state == 'b01) && (previous_state == 'b11)) || 
            ((state == 'b00) && (previous_state == 'b01))) begin    // True for all cases of cw rotation 
                cw <= 1;
                ccw <= 0;
            end 
        else if (((state == 'b01) && (previous_state == 'b00)) || 
                ((state == 'b11) && (previous_state == 'b01)) || 
                ((state == 'b10) && (previous_state == 'b11)) || 
                ((state == 'b00) && (previous_state == 'b10))) begin    // True for all cases of ccw rotation 
                    cw <= 0;
                    ccw <= 1;
                end 
        else begin  // Set both cw and ccw to 0 if no rotation 
            cw <= 0;
            ccw <= 0;
        end  
    end 
endmodule





