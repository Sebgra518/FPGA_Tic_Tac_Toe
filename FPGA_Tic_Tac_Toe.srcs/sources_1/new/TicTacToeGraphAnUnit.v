// Listing 13.5
module TicTacToeGraphAnUnit(
input wire clk,reset,
input wire video_on,
input wire selectButton,
input wire leftButton,
input wire rightButton,
input wire upButton,
input wire downButton,
input wire playerStartSelectSwitch,
input wire [9:0] pix_x, pix_y,
output reg [11:0] graph_rgb, reg playWinSFX,
output reg [1:0] soundSelect);

// constant and signal declaration
   // x, y coordinates (0,0) to (639,479)
   localparam MAX_X = 640;
   localparam MAX_Y = 480;
   
   localparam squareSize = 100;
   
   //Referncing the top left of the grid
   localparam squareY = 50;
   localparam squareX = 150;
   
   //Spacing in between each square
   localparam gap = 5;
   
   //X
   localparam xSquareSize = 5;
   localparam xFullSize = 140;
   localparam maxSquareX = 100;
   
   
   wire refr_tick;
   //--------------------------------------------
   // vertical stripe as a wall
   //--------------------------------------------
   
   //TopLeftSquare
   localparam TopLeft_T = squareY;
   localparam TopLeft_B = squareY + squareSize;
   localparam TopLeft_L = squareX;
   localparam TopLeft_R = squareX + squareSize;
   
   //TopCenterSquare
   localparam TopCenter_T = squareY;
   localparam TopCenter_B = squareY + squareSize;
   localparam TopCenter_L = squareX + squareSize + gap;
   localparam TopCenter_R = squareX + squareSize + gap + squareSize;
   
   //TopRightSquare
   localparam TopRight_T = squareY;
   localparam TopRight_B = squareY + squareSize;
   localparam TopRight_L = squareX + squareSize + gap + squareSize + gap;
   localparam TopRight_R = squareX + squareSize + gap + squareSize + squareSize + gap;
   
   
   
   //CenterLeftSquare
   localparam CenterLeft_T = squareY + squareSize + gap;
   localparam CenterLeft_B = squareY + squareSize + gap + squareSize;
   localparam CenterLeft_L = squareX;
   localparam CenterLeft_R = squareX + squareSize;
   
   //CenterCenterSquare
   localparam CenterCenter_T = squareY + squareSize + gap;
   localparam CenterCenter_B = squareY + squareSize + gap + squareSize;
   localparam CenterCenter_L = squareX + squareSize + gap;
   localparam CenterCenter_R = squareX + squareSize + gap + squareSize;
   
   //CenterRightSquare
   localparam CenterRight_T = squareY + squareSize + gap;
   localparam CenterRight_B = squareY + squareSize + gap + squareSize;
   localparam CenterRight_L = squareX + squareSize + gap + squareSize + gap;
   localparam CenterRight_R = squareX + squareSize + gap + squareSize + squareSize + gap;
   
   
   
   //BottomLeftSquare
   localparam BottomLeft_T = squareY + squareSize + gap + squareSize + gap;
   localparam BottomLeft_B = squareY + squareSize + gap + squareSize + gap + squareSize;
   localparam BottomLeft_L = squareX;
   localparam BottomLeft_R = squareX + squareSize;
   
   //BottomCenterSquare
   localparam BottomCenter_T = squareY + squareSize + gap + squareSize + gap;
   localparam BottomCenter_B = squareY + squareSize + gap + squareSize + gap + squareSize;
   localparam BottomCenter_L = squareX + squareSize + gap;
   localparam BottomCenter_R = squareX + squareSize + gap + squareSize;
   
   //BottomRightSquare
   localparam BottomRight_T = squareY + squareSize + gap + squareSize + gap;
   localparam BottomRight_B = squareY + squareSize + gap + squareSize + gap + squareSize;
   localparam BottomRight_L = squareX + squareSize + gap + squareSize + gap;
   localparam BottomRight_R = squareX + squareSize + gap + squareSize + squareSize + gap;
   
   //TOP LEFT X
    localparam X_CENTER      = squareX + 50;
    localparam Y_CENTER      = squareY + 50;
    localparam ARM_LENGTH    = 30;  // Length of the "X" arms
   
   assign topLeft_x_line1 = 
        (pix_x >= (X_CENTER - ARM_LENGTH)) && (pix_x <= (X_CENTER + ARM_LENGTH)) &&
        (pix_y == (pix_x - (X_CENTER - Y_CENTER)));

    assign topLeft_x_line2 = 
        (pix_x >= (X_CENTER - ARM_LENGTH)) && (pix_x <= (X_CENTER + ARM_LENGTH)) &&
        (pix_y == ((X_CENTER + Y_CENTER) - pix_x));
  
   
   //Top Center X
    localparam X_CENTER_2     = X_CENTER + gap + 100;
   
   assign topCenter_x_line1 = 
        (pix_x >= (X_CENTER_2 - ARM_LENGTH)) && (pix_x <= (X_CENTER_2 + ARM_LENGTH)) &&
        (pix_y == (pix_x - (X_CENTER_2 - Y_CENTER)));

    assign topCenter_x_line2 = 
        (pix_x >= (X_CENTER_2 - ARM_LENGTH)) && (pix_x <= (X_CENTER_2 + ARM_LENGTH)) &&
        (pix_y == ((X_CENTER_2 + Y_CENTER) - pix_x));
   
    //Top Right X
    localparam X_CENTER_3     = X_CENTER_2 + gap + 100;
   
   assign topRight_x_line1 = 
        (pix_x >= (X_CENTER_3 - ARM_LENGTH)) && (pix_x <= (X_CENTER_3 + ARM_LENGTH)) &&
        (pix_y == (pix_x - (X_CENTER_3 - Y_CENTER)));

    assign topRight_x_line2 = 
        (pix_x >= (X_CENTER_3 - ARM_LENGTH)) && (pix_x <= (X_CENTER_3 + ARM_LENGTH)) &&
        (pix_y == ((X_CENTER_3 + Y_CENTER) - pix_x));




    //CENTER LEFT X
    localparam Y_CENTER_2      = squareY + gap + 100 + 50;
   
   assign centerLeft_x_line1 = 
        (pix_x >= (X_CENTER - ARM_LENGTH)) && (pix_x <= (X_CENTER + ARM_LENGTH)) &&
        (pix_y == (pix_x - (X_CENTER - Y_CENTER_2)));

    assign centerLeft_x_line2 = 
        (pix_x >= (X_CENTER - ARM_LENGTH)) && (pix_x <= (X_CENTER + ARM_LENGTH)) &&
        (pix_y == ((X_CENTER + Y_CENTER_2) - pix_x));
   
   //CENTER Center X
   assign centerCenter_x_line1 = 
        (pix_x >= (X_CENTER_2 - ARM_LENGTH)) && (pix_x <= (X_CENTER_2 + ARM_LENGTH)) &&
        (pix_y == (pix_x - (X_CENTER_2 - Y_CENTER_2)));

    assign centerCenter_x_line2 = 
        (pix_x >= (X_CENTER_2 - ARM_LENGTH)) && (pix_x <= (X_CENTER_2 + ARM_LENGTH)) &&
        (pix_y == ((X_CENTER_2 + Y_CENTER_2) - pix_x));
   
    //CENTER Right X
   assign centerRight_x_line1 = 
        (pix_x >= (X_CENTER_3 - ARM_LENGTH)) && (pix_x <= (X_CENTER_3 + ARM_LENGTH)) &&
        (pix_y == (pix_x - (X_CENTER_3 - Y_CENTER_2)));

    assign centerRight_x_line2 = 
        (pix_x >= (X_CENTER_3 - ARM_LENGTH)) && (pix_x <= (X_CENTER_3 + ARM_LENGTH)) &&
        (pix_y == ((X_CENTER_3 + Y_CENTER_2) - pix_x));
   
   
 
 
 
     //Bottom LEFT X
    localparam Y_CENTER_3      = Y_CENTER_2 + gap + 100;
   
   assign bottomLeft_x_line1 = 
        (pix_x >= (X_CENTER - ARM_LENGTH)) && (pix_x <= (X_CENTER + ARM_LENGTH)) &&
        (pix_y == (pix_x - (X_CENTER - Y_CENTER_3)));

    assign bottomLeft_x_line2 = 
        (pix_x >= (X_CENTER - ARM_LENGTH)) && (pix_x <= (X_CENTER + ARM_LENGTH)) &&
        (pix_y == ((X_CENTER + Y_CENTER_3) - pix_x));
   
   //BOTTOM Center X
   assign bottomCenter_x_line1 = 
        (pix_x >= (X_CENTER_2 - ARM_LENGTH)) && (pix_x <= (X_CENTER_2 + ARM_LENGTH)) &&
        (pix_y == (pix_x - (X_CENTER_2 - Y_CENTER_3)));

    assign bottomCenter_x_line2 = 
        (pix_x >= (X_CENTER_2 - ARM_LENGTH)) && (pix_x <= (X_CENTER_2 + ARM_LENGTH)) &&
        (pix_y == ((X_CENTER_2 + Y_CENTER_3) - pix_x));
   
    //CENTER Right X
   assign bottomRight_x_line1 = 
        (pix_x >= (X_CENTER_3 - ARM_LENGTH)) && (pix_x <= (X_CENTER_3 + ARM_LENGTH)) &&
        (pix_y == (pix_x - (X_CENTER_3 - Y_CENTER_3)));

    assign bottomRight_x_line2 = 
        (pix_x >= (X_CENTER_3 - ARM_LENGTH)) && (pix_x <= (X_CENTER_3 + ARM_LENGTH)) &&
        (pix_y == ((X_CENTER_3 + Y_CENTER_3) - pix_x));
   
   
   
   
   
   //TOP LEFT O
    parameter INNER_RADIUS = 40; // Inner radius of the ring
    parameter OUTER_RADIUS = 42; // Outer radius of the ring
    
   assign topLeft_o = (pix_x - X_CENTER)*(pix_x - X_CENTER) + (pix_y - Y_CENTER)*(pix_y - Y_CENTER) >= INNER_RADIUS*INNER_RADIUS && (pix_x - X_CENTER)*(pix_x - X_CENTER) + (pix_y - Y_CENTER)*(pix_y - Y_CENTER) <= OUTER_RADIUS*OUTER_RADIUS;
   
   assign topCenter_o = (pix_x - X_CENTER_2)*(pix_x - X_CENTER_2) + (pix_y - Y_CENTER)*(pix_y - Y_CENTER) >= INNER_RADIUS*INNER_RADIUS && (pix_x - X_CENTER_2)*(pix_x - X_CENTER_2) + (pix_y - Y_CENTER)*(pix_y - Y_CENTER) <= OUTER_RADIUS*OUTER_RADIUS;
   
   assign topRight_o = (pix_x - X_CENTER_3)*(pix_x - X_CENTER_3) + (pix_y - Y_CENTER)*(pix_y - Y_CENTER) >= INNER_RADIUS*INNER_RADIUS && (pix_x - X_CENTER_3)*(pix_x - X_CENTER_3) + (pix_y - Y_CENTER)*(pix_y - Y_CENTER) <= OUTER_RADIUS*OUTER_RADIUS;
   
   
   
   assign centerLeft_o = (pix_x - X_CENTER)*(pix_x - X_CENTER) + (pix_y - Y_CENTER_2)*(pix_y - Y_CENTER_2) >= INNER_RADIUS*INNER_RADIUS && (pix_x - X_CENTER)*(pix_x - X_CENTER) + (pix_y - Y_CENTER_2)*(pix_y - Y_CENTER_2) <= OUTER_RADIUS*OUTER_RADIUS;
   
   assign centerCenter_o = (pix_x - X_CENTER_2)*(pix_x - X_CENTER_2) + (pix_y - Y_CENTER_2)*(pix_y - Y_CENTER_2) >= INNER_RADIUS*INNER_RADIUS && (pix_x - X_CENTER_2)*(pix_x - X_CENTER_2) + (pix_y - Y_CENTER_2)*(pix_y - Y_CENTER_2) <= OUTER_RADIUS*OUTER_RADIUS;
   
   assign centerRight_o = (pix_x - X_CENTER_3)*(pix_x - X_CENTER_3) + (pix_y - Y_CENTER_2)*(pix_y - Y_CENTER_2) >= INNER_RADIUS*INNER_RADIUS && (pix_x - X_CENTER_3)*(pix_x - X_CENTER_3) + (pix_y - Y_CENTER_2)*(pix_y - Y_CENTER_2) <= OUTER_RADIUS*OUTER_RADIUS;
   
   
   assign bottomLeft_o = (pix_x - X_CENTER)*(pix_x - X_CENTER) + (pix_y - Y_CENTER_3)*(pix_y - Y_CENTER_3) >= INNER_RADIUS*INNER_RADIUS && (pix_x - X_CENTER)*(pix_x - X_CENTER) + (pix_y - Y_CENTER_3)*(pix_y - Y_CENTER_3) <= OUTER_RADIUS*OUTER_RADIUS;
   
   assign bottomCenter_o = (pix_x - X_CENTER_2)*(pix_x - X_CENTER_2) + (pix_y - Y_CENTER_3)*(pix_y - Y_CENTER_3) >= INNER_RADIUS*INNER_RADIUS && (pix_x - X_CENTER_2)*(pix_x - X_CENTER_2) + (pix_y - Y_CENTER_3)*(pix_y - Y_CENTER_3) <= OUTER_RADIUS*OUTER_RADIUS;
   
   assign bottomRight_o = (pix_x - X_CENTER_3)*(pix_x - X_CENTER_3) + (pix_y - Y_CENTER_3)*(pix_y - Y_CENTER_3) >= INNER_RADIUS*INNER_RADIUS && (pix_x - X_CENTER_3)*(pix_x - X_CENTER_3) + (pix_y - Y_CENTER_3)*(pix_y - Y_CENTER_3) <= OUTER_RADIUS*OUTER_RADIUS;
   

   //--------------------------------------------
   // object output signals
   //--------------------------------------------
   wire TopLeft_on, TopCenter_on, TopRight_on;
   wire CenterLeft_on, CenterCenter_on, CenterRight_on;
   wire BottomLeft_on, BottomCenter_on, BottomRight_on;
   
   reg [3:0] selectLoc, selectLoc_next;
   

    reg buttonEnable;
    reg buttonEnable_next;

    reg player; //1-X; 2-O
    reg player_next;

    reg [3:0] turnStore;
    reg [3:0] turnStore_next;
   // body
   
   reg [8:0] redBoard, redBoard_next; //Bored to save red locations
   reg [8:0] blueBoard, blueBoard_next;
   reg [1:0] RedBlueWin, RedBlueWin_next;


 reg playWinSFX_next;
 reg [1:0] soundSelect_next;
 
   // registers
   always @(posedge clk, posedge reset)
      if (reset)
         begin
            soundSelect <= 0;
            playWinSFX <= 0;
            RedBlueWin <= 0;
            player <= 0;
            redBoard <= 0;
            blueBoard <= 0;
            turnStore <= 0;
            buttonEnable <= 1;
            selectLoc <= 4'd5;
         end
      else
         begin
            soundSelect <= soundSelect_next;
            playWinSFX <= playWinSFX_next;
            RedBlueWin <= RedBlueWin_next;
            player <= player_next;
            redBoard <= redBoard_next;
            blueBoard <= blueBoard_next;
            turnStore <= turnStore_next;
            buttonEnable <= buttonEnable_next;
            selectLoc <= selectLoc_next;
         end

   // refr_tick: 1-clock tick asserted at start of v-sync
   //            i.e., when the screen is refreshed (60 Hz)
   assign refr_tick = (pix_y==481) && (pix_x==0);

   //--------------------------------------------
   // (wall) left vertical strip
   //--------------------------------------------
   
   

   // Squares
   assign TopLeft_on = (TopLeft_T<=pix_y) && (pix_y<=TopLeft_B) && (TopLeft_L<=pix_x) && (pix_x<=TopLeft_R);
   assign TopCenter_on = (TopCenter_T<=pix_y) && (pix_y<=TopCenter_B) && (TopCenter_L<=pix_x) && (pix_x<=TopCenter_R);
   assign TopRight_on = (TopRight_T<=pix_y) && (pix_y<=TopRight_B) && (TopRight_L<=pix_x) && (pix_x<=TopRight_R);
   assign CenterLeft_on = (CenterLeft_T<=pix_y) && (pix_y<=CenterLeft_B) && (CenterLeft_L<=pix_x) && (pix_x<=CenterLeft_R);
   assign CenterCenter_on = (CenterCenter_T<=pix_y) && (pix_y<=CenterCenter_B) && (CenterCenter_L<=pix_x) && (pix_x<=CenterCenter_R);
   assign CenterRight_on = (CenterRight_T<=pix_y) && (pix_y<=CenterRight_B) && (CenterRight_L<=pix_x) && (pix_x<=CenterRight_R);
   assign BottomLeft_on = (BottomLeft_T<=pix_y) && (pix_y<=BottomLeft_B) && (BottomLeft_L<=pix_x) && (pix_x<=BottomLeft_R);
   assign BottomCenter_on = (BottomCenter_T<=pix_y) && (pix_y<=BottomCenter_B) && (BottomCenter_L<=pix_x) && (pix_x<=BottomCenter_R);
   assign BottomRight_on = (BottomRight_T<=pix_y) && (pix_y<=BottomRight_B) && (BottomRight_L<=pix_x) && (pix_x<=BottomRight_R);
   
   assign hashOn = (squareY - gap <=pix_y) && (pix_y<=BottomLeft_B + gap) && (squareX - gap <=pix_x) && (pix_x<=TopRight_R + gap);
   
   assign defult_square_rgb = 12'b000000000000; //Black
   
   reg [11:0] select_square_rgb; 

   
   // Cursor Select
   always @* begin
      selectLoc_next = selectLoc;
      buttonEnable_next = buttonEnable;
      turnStore_next = turnStore;
      redBoard_next = redBoard;
      blueBoard_next = blueBoard;
      player_next = player;
      RedBlueWin_next = RedBlueWin;
      playWinSFX_next = playWinSFX;
      soundSelect_next = soundSelect;

      
      if (refr_tick) begin
      
            //Starting player
            if(turnStore == 0) begin
                if(playerStartSelectSwitch == 1) begin
                    player_next = 1;
                    select_square_rgb = 12'b000000001001; //red X
                end
                else begin   
                    player_next = 0;
                    select_square_rgb = 12'b100100000000; //blue O
                end
            end
              
              //Cursor Movement
             if (downButton) begin
                if(buttonEnable && selectLoc < 7) begin
                    selectLoc_next = selectLoc + 3; // move down
                    buttonEnable_next <= 0;
                end
             end
             
             else if (upButton && selectLoc > 3) begin
                if(buttonEnable) begin
                    selectLoc_next = selectLoc - 3; // move up
                    buttonEnable_next <= 0;
                end
             end
             
             else if (leftButton && (selectLoc != 1 && selectLoc != 4 && selectLoc != 7)) begin
                if(buttonEnable) begin
                    selectLoc_next = selectLoc - 1; // move left
                    buttonEnable_next <= 0;
                end
             end
             
             else if (rightButton && (selectLoc != 3 && selectLoc != 6 && selectLoc != 9)) begin
                if(buttonEnable) begin
                    selectLoc_next = selectLoc + 1; // move left 
                    buttonEnable_next <= 0;
                end
             end 
             
             //SelectButton
             else if(selectButton) begin
                if(buttonEnable) begin
                    if(player == 1 && (blueBoard[selectLoc - 1] != 1)) begin
                        redBoard_next[selectLoc - 1] = 1;
                        turnStore_next = turnStore + 1; // move left 
                        buttonEnable_next <= 0;
                        player_next <= ~player;
                        
                        playWinSFX_next = 1;
                        soundSelect_next = 2;
                        
                    end
                    if(player == 0 && (redBoard[selectLoc - 1] != 1)) begin
                        blueBoard_next[selectLoc - 1] = 1;
                        turnStore_next = turnStore + 1; // move left 
                        buttonEnable_next <= 0;
                        player_next <= ~player;
                        
                        playWinSFX_next = 1;
                        soundSelect_next = 2;
                        
                    end
                end
             end
             
             
             
             //Reset ButtonEnable
             else begin
                 if(soundSelect == 2) begin
                        playWinSFX_next = 0;
                        soundSelect_next = 2;
                 end
                buttonEnable_next <= 1;
                if(player == 1) begin
                    select_square_rgb = 12'b000000001001; //red X
                end
                else begin   
                    select_square_rgb = 12'b100100000000; //blue O
                end
             end
         end  
         
         
 ////////////////////////////////////////////////////////////////////////////////   CHECK WIN
 
 ///////////////////////////////////// RED
 
        //Top LEft Conditions
       if((redBoard[0] == 1) && ((redBoard[1] == 1 && redBoard[2] == 1) || (redBoard[3] == 1 && redBoard[6] == 1))) begin
             RedBlueWin_next = 1;
       end
       
       //Bottom Right Conditions
       else if((redBoard[8] == 1) && ((redBoard[7] == 1 && redBoard[6] == 1) || (redBoard[5] == 1 && redBoard[2] == 1))) begin
            RedBlueWin_next = 1;
       end
       
       //Center Conditions
       else if((redBoard[4] == 1) && ((redBoard[3] == 1 && redBoard[5] == 1) || (redBoard[1] == 1 && redBoard[7] == 1) || (redBoard[2] == 1 && redBoard[6] == 1) || (redBoard[0] == 1 && redBoard[8] == 1))) begin
            RedBlueWin_next = 1;
       end
       
////////////////////////////////////////    BLUE
       
       //Top LEft Conditions
       else if((blueBoard[0] == 1) && ((blueBoard[1] == 1 && blueBoard[2] == 1) || (blueBoard[3] == 1 && blueBoard[6] == 1))) begin
            RedBlueWin_next = 2;
       end
       
       //Bottom Right Conditions
       else if((blueBoard[8] == 1) && ((blueBoard[7] == 1 && blueBoard[6] == 1) || (blueBoard[5] == 1 && blueBoard[2] == 1))) begin
             RedBlueWin_next = 2;
       end
       
       //Center Conditions
       else if((blueBoard[4] == 1) && ((blueBoard[3] == 1 && blueBoard[5] == 1) || (blueBoard[1] == 1 && blueBoard[7] == 1) || (blueBoard[2] == 1 && blueBoard[6] == 1) || (blueBoard[0] == 1 && blueBoard[8] == 1))) begin
                RedBlueWin_next = 2;
       end 
       else if(turnStore == 9) begin
            RedBlueWin_next = 3;
            playWinSFX_next = 1;
            soundSelect_next = 1;
        end
       
/////////////////////////////////////////////////////////////////   RGB
       
       if (~video_on) begin
         graph_rgb = 12'b000000000000; // blank
      end else begin
      
      if(RedBlueWin == 1) begin
        graph_rgb = 12'b000000001111;
        soundSelect_next = 0;
        playWinSFX_next = 1;
      end else
      if(RedBlueWin == 2) begin
        graph_rgb = 12'b111100000000;
        soundSelect_next = 0;
        playWinSFX_next = 1;
      end else if(RedBlueWin == 3) begin
        graph_rgb = 12'b111100001111;
        playWinSFX_next = 1;
        soundSelect_next = 1;
      end else
      
      
      
      //O
        if (topLeft_o && blueBoard[0] == 1) begin
            graph_rgb = 12'b111100000000;
        end else if (topCenter_o && blueBoard[1] == 1) begin
            graph_rgb = 12'b111100000000;
        end else if (topRight_o && blueBoard[2] == 1) begin
            graph_rgb = 12'b111100000000;
        end else if (centerLeft_o && blueBoard[3] == 1) begin
            graph_rgb = 12'b111100000000;
        end else if (centerCenter_o && blueBoard[4] == 1) begin
            graph_rgb = 12'b111100000000;
        end else if (centerRight_o && blueBoard[5] == 1) begin
            graph_rgb = 12'b111100000000;
        end else if (bottomLeft_o && blueBoard[6] == 1) begin
            graph_rgb = 12'b111100000000;
        end else if (bottomCenter_o && blueBoard[7] == 1) begin
            graph_rgb = 12'b111100000000;
        end else if (bottomRight_o && blueBoard[8] == 1) begin
            graph_rgb = 12'b111100000000;
        end else
      
      
           //X
           if ((topLeft_x_line1 || topLeft_x_line2) && redBoard[0] == 1) begin
            graph_rgb = 12'b000000001111;
           end 
           else if ((topCenter_x_line1 || topCenter_x_line2) && redBoard[1] == 1) begin
            graph_rgb = 12'b000000001111;
           end 
           else if ((topRight_x_line1 || topRight_x_line2) && redBoard[2] == 1) begin
            graph_rgb = 12'b000000001111;
           end else if ((centerLeft_x_line1 || centerLeft_x_line2) && redBoard[3] == 1) begin
            graph_rgb = 12'b000000001111;
           end 
           else if ((centerCenter_x_line1 || centerCenter_x_line2)  && redBoard[4] == 1) begin
            graph_rgb = 12'b000000001111;
           end 
           else if ((centerRight_x_line1 || centerRight_x_line2) && redBoard[5] == 1) begin
            graph_rgb = 12'b000000001111;
           end 
           else if ((bottomLeft_x_line1 || bottomLeft_x_line2) && redBoard[6] == 1) begin
            graph_rgb = 12'b000000001111;
           end 
           else if ((bottomCenter_x_line1 || bottomCenter_x_line2) && redBoard[7] == 1) begin
            graph_rgb = 12'b000000001111;
           end 
           else if ((bottomRight_x_line1 || bottomRight_x_line2) && redBoard[8] == 1) begin
            graph_rgb = 12'b000000001111;
           end 

           //BlackSquares
          else if (TopLeft_on) begin
            if(selectLoc == 1) 
              graph_rgb = select_square_rgb;
            else
              graph_rgb = defult_square_rgb;
          end
             
          else if (TopCenter_on) begin
            if(selectLoc == 2) 
              graph_rgb = select_square_rgb;
            else
              graph_rgb = defult_square_rgb;
          end
             
          else if (TopRight_on) begin
            if(selectLoc == 3) 
              graph_rgb = select_square_rgb;
            else
              graph_rgb = defult_square_rgb;
          end
             
          else if (CenterLeft_on) begin
              if(selectLoc == 4) 
              graph_rgb = select_square_rgb;
            else
              graph_rgb = defult_square_rgb;
          end
             
          else if (CenterCenter_on) begin
              if(selectLoc == 5) 
              graph_rgb = select_square_rgb;
            else
              graph_rgb = defult_square_rgb;
          end
             
          else if (CenterRight_on) begin
             if(selectLoc == 6) 
              graph_rgb = select_square_rgb;
            else
              graph_rgb = defult_square_rgb;
          end
              
          else if (BottomLeft_on) begin
              if(selectLoc == 7) 
              graph_rgb = select_square_rgb;
            else
              graph_rgb = defult_square_rgb;
          end
             
          else if (BottomCenter_on) begin
              if(selectLoc == 8) 
              graph_rgb = select_square_rgb;
            else
              graph_rgb = defult_square_rgb;
          end
             
          else if (BottomRight_on) begin
              if(selectLoc == 9) 
              graph_rgb = select_square_rgb;
            else
              graph_rgb = defult_square_rgb;
          end
          
          else if (hashOn) begin
             graph_rgb = 12'b111111111111; // White
          end
          
          else
             graph_rgb = 12'b000000000000; // black background
          end
   end
   
  
  

    
endmodule