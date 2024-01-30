// ELEX 7660 Lab 3 
// Nicholas Scott AKA "White Cheddar"
// January 27th, 2024
// Instructor: Sweet Bobby T

module tonegen 
  #( parameter FCLK )           // clock frequency, Hz 
   ( input logic [31:0] freq,   // frequency to output on speaker 
     input logic onOff,         // 1 -> generate output, 0-> no output 
     output logic spkr,         // speaker output 
     input logic reset_n, clk); // reset and clock  

    logic [31:0] count; 
    logic prevOnOff; 
    logic mute = 0; 

    always_ff @( posedge clk) begin 

        // latch and debounce for mute button 
        prevOnOff <= onOff; 
        if (!onOff && prevOnOff)
            mute <= ~mute; 

        if (reset_n) begin              // if  active-low reset not pressed  
            count <= count + (freq<<1); // count up by twice the tone frequency 
            // if count reaches clock frequency minus one increment 
            if (count >= (FCLK - (freq<<1))) begin  
                if (!mute)              // if mute is not pressed
                    spkr <= ~spkr;      // toggle speaker every 1/2 period
                count <= 0;             // reset count
            end 
        end 
        else begin  // reset speaker and count if reset is pressed
            spkr <= 0;                             
            count <= 0; 
        end 
    end
endmodule 