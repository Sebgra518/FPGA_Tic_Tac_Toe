module WinMusicSheet( input [9:0] number,
    output reg [19:0] note,//what is the max frequency
    output reg [4:0] duration,
    input wire [1:0] soundSelect);
    
    
    parameter EIGHTH = 5'b00001;
    parameter QUARTER = 5'b00010;
    parameter HALF = 5'b00100;
    parameter ONE = 2* HALF;
    parameter TWO = 2* ONE;
    parameter FOUR = 2* TWO;
    parameter C4=191113, D4=170262, E4 = 151870, F4=143173 , G4 = 127553,C5 = 95557, Fs5 = 67568,Ab5 = 60197,Eb5 = 80254, SP = 1;
    
    always @ (number) begin
        if(soundSelect == 0) begin
            case(number) //Row Row Row your boat
                0: begin note = Ab5; duration = EIGHTH; end // Ab
                1: begin note = Fs5; duration = EIGHTH; end // F#
                2: begin note = Ab5; duration = EIGHTH; end //Ab
                3: begin note = Eb5; duration = EIGHTH; end //Eb
                4: begin note = SP ; duration = EIGHTH; end //rest
                5: begin note = Fs5; duration = EIGHTH; end //F#
                6: begin note = SP; duration = EIGHTH; end //rest
                7: begin note = Ab5; duration = QUARTER; end //Ab
                default: begin note = SP; duration = FOUR; end
            endcase
         end else if(soundSelect == 1) begin
            case(number) //Row Row Row your boat
                0: begin note = E4; duration = EIGHTH; end // Ab
                1: begin note = D4; duration = EIGHTH; end // F#
                2: begin note = C4; duration = EIGHTH; end //Ab
                3: begin note = SP; duration = EIGHTH; end //Eb
                4: begin note = SP ; duration = EIGHTH; end //rest
                5: begin note = SP; duration = EIGHTH; end //F#
                6: begin note = SP; duration = EIGHTH; end //rest
                7: begin note = SP; duration = QUARTER; end //Ab
                default: begin note = SP; duration = FOUR; end
            endcase
         end else if(soundSelect == 2) begin
            case(number) 
                0: begin note = Ab5; duration = EIGHTH; end // Ab
                1: begin note = SP; duration = EIGHTH; end // F#
                2: begin note = SP; duration = EIGHTH; end //Ab
                3: begin note = SP; duration = EIGHTH; end //Eb
                4: begin note = SP ; duration = EIGHTH; end //rest
                5: begin note = SP; duration = EIGHTH; end //F#
                6: begin note = SP; duration = EIGHTH; end //rest
                7: begin note = SP; duration = EIGHTH; end //Ab
                default: begin note = SP; duration = FOUR; end
            endcase
         end
         
         
    end
    
endmodule