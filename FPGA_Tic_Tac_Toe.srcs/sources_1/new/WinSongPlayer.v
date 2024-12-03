module WinSongPlayer(input clock, input reset, input playSound, output reg audioOut, output wire aud_sd, input wire [1:0] playSoundSelect);
    reg [19:0] counter;
    reg [31:0] time1, noteTime;
    reg [9:0] msec, number; //millisecond counter, and sequence number of musical
    wire [4:0] note, duration;
    wire [19:0] notePeriod;
    parameter clockFrequency = 100_000_000;
    reg songEnable;
    assign aud_sd = 1'b1;
    
    WinMusicSheet winMusicSheet(number, notePeriod, duration, playSoundSelect);
   

    always @ (posedge clock) begin
    
        if(reset | ~playSound) begin
            counter <=0;
            time1<=0;
            number <=0;
            audioOut <=1;
            songEnable <= 1;
        end else if(songEnable == 1)begin
            counter <= counter + 1;
            time1<= time1+1;
            if( counter >= notePeriod) begin
                counter <=0;
                audioOut <= ~audioOut ;
            end
        
             //toggle audio output
            if( time1 >= noteTime)begin
                time1 <=0;
                number <= number + 1;
            end 
        
            //play next note
            if(number == 8) begin
                number <=0; // Make the number reset at the end of the song
                songEnable <= 0;
             end
        end
    end
    always @(duration)
        noteTime = duration * clockFrequency/8;
    //number of FPGA clock periods in one note.
endmodule