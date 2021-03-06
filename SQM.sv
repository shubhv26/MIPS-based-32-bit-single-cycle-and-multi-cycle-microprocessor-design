module SQM(input logic [3:0]B, 
	      input logic [7:0]A,
	      output logic [7:0]C,   
              output logic [7:0]Y);
always_comb
begin
assign C=B*B;
if(A!=0)
	Y=C%A; 
else
	Y=8'bXXXXXXXX;
end
endmodule
 