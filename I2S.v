module I2S(

		CLOCK_50,
		KEY,
		LED,
		ledbit,

	SCK,
	SD,
	WS	
);

//=======================================================
//  PARAMETER declarations
//=======================================================


//=======================================================
//  PORT declarations
//=======================================================

//////////// CLOCK //////////
input 		          		CLOCK_50;
input KEY;

//////////// LED //////////
output	reg	     [7:0]		LED;
output ledbit;

//////////// KEY //////////

output		          		SCK;
inout 		          		SD;
output                 WS;

//=======================================================
//  REG/WIRE declarations
//=======================================================
wire       	 	reset_n;													//reset signal

wire a, b;
reg				WS_b;
reg				GO; 														
reg 				[9:0] SD_COUNTER; 									
//reg 				SD;
reg 				[6:0] COUNT_WS;													
reg 				SCLK; 	
											
reg	[4:0]		COUNT; 
reg [31:0]   start_count=0;													

//=============================================================================
// Structural coding
//=============================================================================
assign   reset_n = KEY;

/////////////////////////////////////////////////////////////////////

always@(posedge CLOCK_50) COUNT <= COUNT + 1;

always@(posedge COUNT[4]) COUNT_WS <= COUNT_WS + 1;


assign ledbit=0;
always LED[7]=SD;

always @ (start_count)// or negedge reset_n) //3.7 MHz
begin
	if (start_count ==262144)
		GO <= 1;
	else
		//if(!KEY)
		GO <= 0;
end


always @(posedge COUNT[4]) start_count<= start_count+1;



always @(posedge COUNT[4])// or negedge reset_n) 
begin
	if (!reset_n) 
	begin 

		SD_COUNTER<=0; 
		
		end
	else 
	if  (start_count >= 262144)
		
		SD_COUNTER <= SD_COUNTER+1;
		
	end	
		
		
	
	assign	SD = ((SD_COUNTER >= 2) & (SD_COUNTER <= 26)) ? 1'bz : 0;
	assign	 WS =  COUNT_WS[6];
	
	
		
assign SCK =(SD_COUNTER >= 1)  ? ~COUNT[4] : 1;


endmodule
