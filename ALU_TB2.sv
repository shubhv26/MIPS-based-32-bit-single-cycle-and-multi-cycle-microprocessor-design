module alu_tb2();
logic clk,reset;
logic [31:0] a,b;
logic [31:0]y;
logic [31:0]yexp;
logic [2:0] f;
logic zero; 
logic zeroExp;
logic [31:0] vectornum, errors;   //array of bookkeeping variables
logic[99:0] testvectors[1000:0];  //array of testvectors
int tot_case=25; 

alu dut(.f(f),.a(a),.b(b),.y(y),.zero(zero)); //Port mapping

always
	begin
	clk=1; #5; clk=0; #5;    //Clock generation
	end

initial
	begin
	$readmemb("C:/Users/Shubham/Desktop/SEM 2/HDL/Modelsim files/testvectors.txt",testvectors);
	vectornum=0; errors=0;
	reset=1; #27; reset=0;
	end

always @(posedge clk)
begin 
	#1; {f,a,b,yexp,zeroExp}=testvectors[vectornum];
	end

always @(negedge clk)
	if(~reset) begin 
		if (y!==yexp) begin
			$display("Error : input %b",{a,b,f});
			$display("Output = %b (%b expected)",y,yexp);
			errors=errors+1;
		end
vectornum=vectornum+1;
if (vectornum===tot_case) begin
	$display("%d Test completed with %d errors", vectornum, errors);
	$finish;
	end
end
endmodule
 