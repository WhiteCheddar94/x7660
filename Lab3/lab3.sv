// ELEX 7660 Lab 3 
// Nicholas Scott AKA "White Cheddar"
// January 27th, 2024
// Instructor: Sweet Bobby T

module lab3 ( input logic CLOCK_50,       // 50 MHz clock
              (* altera_attribute = "-name WEAK_PULL_UP_RESISTOR ON" *) 
              input logic enc1_a, enc1_b, //Encoder 1 pins
				      (* altera_attribute = "-name WEAK_PULL_UP_RESISTOR ON" *) input logic 
              enc2_a, enc2_b,				      //Encoder 2 pins
              input logic s1, s2,         // reset and onOff pushbuttons
              output logic [7:0] leds,    // 7-seg LED enables
              output logic [3:0] ct,      // digit cathodes
              output logic spkr ) ;       // tone output    

   logic [1:0] digit;  // select digit to display
   logic [3:0] disp_digit;  // current digit of count to display
   logic [15:0] clk_div_count; // count used to divide clock
   logic [31:0] freq;   // tone frequency 

   logic [7:0] enc1_count, enc2_count; // count used to track encoder movement and to display
   logic enc1_cw, enc1_ccw, enc2_cw, enc2_ccw;  // encoder module outputs

   // instantiate modules to implement design
   decode2 decode2_0 (.digit,.ct) ;
   decode7 decode7_0 (.num(disp_digit),.leds) ;
   encoder encoder_1 (.clk(CLOCK_50), .a(enc1_a), .b(enc1_b), .cw(enc1_cw), .ccw(enc1_ccw));
   enc2freq enc2freq_1 (.clk(CLOCK_50), .cw(enc1_cw), .ccw(enc1_ccw), .freq(freq), .reset_n(s1));
   tonegen #(50000000) tonegen_1 (.clk(CLOCK_50), .freq(freq), .spkr(spkr), .onOff(s2), .reset_n(s1));

   // use count to divide clock and generate a 2 bit digit counter to determine which digit to display
   always_ff @(posedge CLOCK_50) 
     clk_div_count <= clk_div_count + 1'b1 ;

  // assign the top two bits of count to select digit to display
  assign digit = clk_div_count[15:14]; 

  // Select digit to display (disp_digit)
  // each digit displays one nibble of tone frequency in hexidecimal 
  always_comb begin
  
    case (digit)
      0 : disp_digit = freq[3:0]; // Set digit 0 to encoder 2 count LSN (Least Significant Nibble)
      1 : disp_digit = freq[7:4]; // Set digit 1 to encoder 2 count MSN
      2 : disp_digit = freq[11:8]; // Set digit 2 to encoder 1 count LSN
      3 : disp_digit = freq[15:12]; // Set digit 3 to encoder 1 count MSN
    endcase 
  
  end  

endmodule


