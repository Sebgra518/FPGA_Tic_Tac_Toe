// Listing 13.6
module TicTacToeTopAN
   (
    input wire clk, reset,
    input wire up,
    input wire down,
    input wire left,
    input wire right,
    input wire select,
    input wire playerStartSwitch,
    output wire hsync, vsync,
    output wire [11:0] rgb,
    output AudioOut,
    output Aud_sd
   );

   // signal declaration
   wire [9:0] pixel_x, pixel_y;
   wire video_on, pixel_tick;
   reg [11:0] rgb_reg;
   wire [11:0] rgb_next;
   wire WinPlaySoundEnable;
    wire clk_50m;
    wire [1:0] playSoundSelect;

    clk_50m_generator myclk(clk, reset, clk_50m);

   // body
   // instantiate vga sync circuit
   vga_sync vsync_unit(.clk(clk_50m), .reset(reset), .hsync(hsync), .vsync(vsync),.video_on(video_on), .p_tick(pixel_tick),.pixel_x(pixel_x), .pixel_y(pixel_y));

   // instantiate graphic generator
   TicTacToeGraphAnUnit pong_graph_an_unit(.clk(clk_50m), .reset(reset), .selectButton(select) , .leftButton(left), .rightButton(right), .upButton(up), .downButton(down), .playerStartSelectSwitch(playerStartSwitch),.video_on(video_on), .pix_x(pixel_x),.pix_y(pixel_y), .graph_rgb(rgb_next), .playWinSFX(WinPlaySoundEnable),.soundSelect(playSoundSelect));
   
   WinSongPlayer winSong(clk,reset, WinPlaySoundEnable, AudioOut, Aud_sd, playSoundSelect);
   
   // rgb buffer
   always @(posedge clk_50m)
      if (pixel_tick)
         rgb_reg <= rgb_next;
   // output
   assign rgb = rgb_reg;

endmodule
