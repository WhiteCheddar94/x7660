// ELEX 7660 Lab 3 
// Nicholas Scott AKA "White Cheddar"
// January 28th, 2024
// Instructor: Sweet Bobby T

module enc2freq 
   ( input logic cw, ccw,       // outputs from lab 2 encoder module 
     output logic [31:0] freq,  // desired frequency 
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
                case (freq) // increment to next frequency of C Major scale 
                    0 : freq <= 262; 
                    262 : freq <= 295; 
                    295 : freq <= 328; 
                    328 : freq <= 349;
                    349 : freq <= 393;
                    393 : freq <= 437;
                    437 : freq <= 491; 
                    491 : freq <= 524; 
                    524 : freq <= 0; // cw rollover
                    default : freq <= 0; 
                endcase
                countup <= 0;
            end
            else if (countdown >= 4) begin // after 4 ccw pulses
                case (freq) // decrement to last frequency of C Major scale
                    0 : freq <= 524;    // ccw rollover
                    524 : freq <= 491; 
                    491 : freq <= 437; 
                    437 : freq <= 393;
                    393 : freq <= 349;
                    349 : freq <= 328;
                    328 : freq <= 295; 
                    295 : freq <= 262; 
                    262 : freq <= 0; 
                    default : freq <= 0; 
                endcase 
                countdown <= 0; 
            end
        end 
        else // set frequency to zero if reset is pressed
            freq <= 0; 
    end
endmodule 