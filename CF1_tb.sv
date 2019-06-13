module CF1_tb();
logic clk,reset;
logic [7:0] A;
logic [7:0]Y,Yexp;
logic [3:0]B;
logic [2:0]f_loc;
logic [1:0]f_type;
logic [7:0]C;
logic [31:0] vectornum, errors;   //array of bookkeeping variables
logic[32:0] testvectors[1000:0];  //array of testvectors
int tot_case=10;

CFI dut(.A(A),.B(B),.C(C),.f_loc(f_loc),.f_type(f_type),.Y(Y));      //Port mapping

always
	begin
	clk=1; #5; clk=0; #5;    //Clock generation
	end
  
initial
	begin
	$readmemb("C:/Users/Shubham/Desktop/SEM 2/HDL/Modelsim files/CFI_vect.txt",testvectors);
	vectornum=0; errors=0;
	reset=1; #27; reset=0;
	end

always @(posedge clk) 
begin 
	#1; {A,B,f_loc,f_type,C,Yexp}=testvectors[vectornum];
	end

always @(negedge clk)
	if(~reset) begin 
		if (Y!==Yexp) begin
			$display("Error : input %b",{A,B});
			$display("Output = %b (%b expected)",Y,Yexp);
			errors=errors+1;
		end
vectornum=vectornum+1;
if (vectornum===tot_case) begin 
	$display("%d Test completed with %d errors", vectornum, errors);
	$finish; 
	end
end
endmodule
