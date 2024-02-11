// ELEX 7660 Lab 4 
// Nicholas Scott AKA "White Cheddar"
// A01255181
// Feb. 6th, 2024
// Instructor: Sweet Bobby T

module lab4 ( input logic ADC_SDO,        // ADC input 
              input logic CLOCK_50,       // 50 MHz clock
              (* altera_attribute = "-name WEAK_PULL_UP_RESISTOR ON" *) 
              input logic enc1_a, enc1_b, // Encoder 1 pins
				      (* altera_attribute = "-name WEAK_PULL_UP_RESISTOR ON" *) 
              input logic enc2_a, enc2_b, // Encoder 2 pins
              input logic s1, s2,         // reset and onOff pushbuttons
              output logic [7:0] leds,    // 7-seg LED enables
              output logic [3:0] ct,      // digit cathodes
              output logic ADC_CONVST, ADC_SCK, ADC_SDI // ADC outputs 
              ); 

   logic [1:0] digit;  // select digit to display
   logic [3:0] disp_digit;  // current digit of count to display
   logic [15:0] clk_div_count; // count used to divide clock
   logic [2:0] chan;  // channel 
   logic [11:0] result; // ADC result 

   logic [7:0] enc1_count, enc2_count; // count used to track encoder movement and to display
   logic enc1_cw, enc1_ccw, enc2_cw, enc2_ccw;  // encoder module outputs

   // instantiate modules to implement design
   decode2 decode2_0 (.digit,.ct) ;
   decode7 decode7_0 (.num(disp_digit),.leds) ;
   encoder encoder_1 (.clk(CLOCK_50), .a(enc1_a), .b(enc1_b), .cw(enc1_cw), .ccw(enc1_ccw));
   enc2chan enc2chan_1 (.clk(CLOCK_50), .cw(enc1_cw), .ccw(enc1_ccw), .chan(chan), .reset_n(s1));
   adcinterface adcinterface_1 (.clk(clk_div_count[15]), .reset_n(s1), .chan(chan), .result, .ADC_CONVST, .ADC_SCK, .ADC_SDI, .ADC_SDO);

   // use count to divide clock and generate a 2 bit digit counter to determine which digit to display
   always_ff @(posedge CLOCK_50) 
     clk_div_count <= clk_div_count + 1'b1 ;

  // assign the top two bits of count to select digit to display
  assign digit = clk_div_count[15:14]; 

  // Select digit to display (disp_digit)
  // the right three digits display the ADC output in hexadecimal 
  // the leftmost digit displays the channel  
  always_comb begin
  
    case (digit)
      0 : disp_digit = result[3:0]; // result LSN (Least Significant Nibble)
      1 : disp_digit = result[7:4]; // the middle nibble 
      2 : disp_digit = result[11:8]; // result MSN
      3 : disp_digit = chan; // Set digit 3 channel
    endcase 
  
  end  

endmodule