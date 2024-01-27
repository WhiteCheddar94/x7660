// ELEX 7660 Lab 2 
// Author: Nicholas Scott AKA "White Cheddar" - SN: A01255181
// Date: Jan 23rd, 2024
// Instructor: Sweet Bobby T

module enc2bcd (input logic clk, cw, ccw,
                output logic [7:0] bcd_count);

    logic [7:0] countup; 
    logic [7:0] countdown; 
    
    always_ff @(posedge clk) begin 
        
        if (cw) 
            countup <= countup + 1; // Count up for cw movement
        else if (ccw)
            countdown <= countdown + 1; // Count "down" for ccw movement 
        
        if (countup >= 4) begin
            bcd_count <= bcd_count + 1; // Increment bcd_count if countup reaches 4
            countup <= 0;
        end
        else if (countdown >= 4) begin
            bcd_count <= bcd_count - 1; // Decrement bcd_count if countdown reaches 4
            countdown <= 0; 
        end

        if ((cw) &&
            ((bcd_count == 'h9) || 
            (bcd_count == 'h19) ||
            (bcd_count == 'h29) || 
            (bcd_count == 'h39) || 
            (bcd_count == 'h49) || 
            (bcd_count == 'h59) || 
            (bcd_count == 'h69) || 
            (bcd_count == 'h79) || 
            (bcd_count == 'h89)))   // If right digit is 9 and movement is cw

            bcd_count <= bcd_count + 7; // Increment count by 7 to skip hex A-F
            
        else if ((ccw) &&
                ((bcd_count == 'h10) || 
                (bcd_count == 'h20) ||
                (bcd_count == 'h30) || 
                (bcd_count == 'h40) || 
                (bcd_count == 'h50) || 
                (bcd_count == 'h60) || 
                (bcd_count == 'h70) || 
                (bcd_count == 'h80) || 
                (bcd_count == 'h90))) // If right digit is 0 and movement is ccw

            bcd_count <= bcd_count - 7; // Decrement count by 7 to skip hex F-A

        else if ((cw) && (bcd_count == 'h99)) 
                bcd_count <= 0;                 // cw rollover from 99->0 

        else if ((ccw) && (bcd_count == 0))
                bcd_count <= 'h99;              // ccw rollover from 0->99
    end
endmodule 
        


         
