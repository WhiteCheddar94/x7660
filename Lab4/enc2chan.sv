// ELEX 7660 Lab 4 
// Nicholas Scott AKA "White Cheddar"
// A01255181
// Feb. 6th, 2024
// Instructor: Sweet Bobby T

module enc2chan 
   ( input logic cw, ccw,       // outputs from lab 2 encoder module 
     output logic [2:0] chan,  // desired channel
     input logic reset_n, clk); // reset and clock  

    logic [7:0] countup = 0; 
    logic [7:0] countdown = 0; 
    
    always_ff @(posedge clk) begin 
        if (reset_n) begin  // if active-low reset  is not pressed  
            if (cw) 
                countup <= countup + 1; // Count up for cw movement
            else if (ccw)
                countdown <= countdown + 1; // Count "down" for ccw movement 
            
            if (countup >= 4) begin // after 4 cw pulses
                case (chan) // increment to next channel
                    0 : chan <= 1; 
                    1 : chan <= 2;
                    2 : chan <= 3; 
                    3 : chan <= 4; 
                    4 : chan <= 5;
                    5 : chan <= 6;
                    6 : chan <= 7;
                    7 : chan <= 0; // cw rollover
                    default : chan <= 0; 
                endcase
                countup <= 0;
            end
            else if (countdown >= 4) begin // after 4 ccw pulses
                case (chan) // decrement to last frequency of C Major scale
                    0 : chan <= 7;    // ccw rollover
                    7 : chan <= 6; 
                    6 : chan <= 5; 
                    5 : chan <= 4;
                    4 : chan <= 3;
                    3 : chan <= 2;
                    2 : chan <= 1; 
                    1 : chan <= 0; 
                    default : chan <= 0; 
                endcase 
                countdown <= 0; 
            end
        end 
        else // set chan to zero if reset is pressed
            chan <= 0; 
    end
endmodule 