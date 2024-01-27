// ELEX 7660 Lab 1
// Nicholas Scott AKA "White Cheddar"
// A01255181
// Instructor: "Sweet" Bobby T

module decode7 (input logic [3:0] num,
				output logic [7:0] leds) ; 

	// assign leds to the necessary bit configuration to display num on 7-segment (in hexidecimal)
	always_comb 
		case(num)						
			0 : leds = 'b00111111; 
			1 : leds = 'b00000110; 
			2 : leds = 'b01011011; 
			3 : leds = 'b01001111; 
			4 : leds = 'b01100111; 
			5 : leds = 'b01101101; 
			6 : leds = 'b01111101; 
			7 : leds = 'b00000111; 
			8 : leds = 'b01111111; 
			9 : leds = 'b01100111; 
			10 : leds = 'b01110111; 	// displays hex character 'A' 
			11 : leds = 'b01111100;		// displays hex character 'b' 
			12 : leds = 'b00111001; 	// displays hex character 'C' 
			13 : leds = 'b01011110; 	// displays hex character 'd'
			14 : leds = 'b01111001; 	// displays hex character 'E'
			15 : leds = 'b01110001;		// displays hex character 'F' 
 		endcase
		
endmodule

			
