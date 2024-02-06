// ELEX 7660 Lab 4
// Nicholas Scott AKA "White Cheddar"
// A01255181
// Feb. 4th, 2024
// Instructor: Sweet Bobby T 

module adcinterface( 
    input logic clk, reset_n,   // clock and reset 
    input logic [2:0] chan,     // ADC channel to sample 
    output logic [11:0] result, // ADC result 
     
    // ltc2308 signals 
    output logic ADC_CONVST, ADC_SCK, ADC_SDI, 
    input logic ADC_SDO  
);

    logic [5:0] word; 
    logic [3:0] count; 
    logic [3:0] adcCount; 
    logic [11:0] tempResult; 

    assign ADC_SCK = ((count >= 2) && (count <= 13)) ? clk : 1'b0;

    always_comb begin 
        case (chan)
            0 : word = '{1, 0, 0, 0, 1, 0};
            1 : word = '{1, 1, 0, 0, 1, 0};
            2 : word = '{1, 0, 0, 1, 1, 0}; 
            3 : word = '{1, 1, 0, 1, 1, 0}; 
            4 : word = '{1, 0, 1, 0, 1, 0}; 
            5 : word = '{1, 1, 1, 0, 1, 0}; 
            6 : word = '{1, 0, 1, 1, 1, 0}; 
            7 : word = '{1, 1, 1, 1, 1, 0}; 
        endcase
    end 
    always_ff @( negedge clk or negedge reset_n ) begin

        count <= count + 1; 

        if (~reset_n) begin 
            count <= 0; 
            ADC_CONVST <= 1; 
        end 
        else 
            case (count)
                0 : ADC_CONVST <= 0;
                1 : ADC_SDI <= word[5]; 
                2 : ADC_SDI <= word[4]; 
                3 : ADC_SDI <= word[3]; 
                4 : ADC_SDI <= word[2]; 
                5 : ADC_SDI <= word[1]; 
                6 : ADC_SDI <= word[0]; 
                15 : ADC_CONVST <= 1; 
                default : ADC_SDI <= 0; 
            endcase      
    end 

    always_ff @(posedge clk)
        
        case (count)
            2 : tempResult[11] <= ADC_SDO; 
            3 : tempResult[10] <= ADC_SDO; 
            4 : tempResult[9] <= ADC_SDO; 
            5 : tempResult[8] <= ADC_SDO; 
            6 : tempResult[7] <= ADC_SDO; 
            7 : tempResult[6] <= ADC_SDO; 
            8 : tempResult[5] <= ADC_SDO; 
            9 : tempResult[4] <= ADC_SDO; 
            10 : tempResult[3] <= ADC_SDO; 
            11 : tempResult[2] <= ADC_SDO; 
            12 : tempResult[1] <= ADC_SDO; 
            13 : tempResult[0] <= ADC_SDO;
            14 : result <= tempResult; 
        endcase

endmodule 