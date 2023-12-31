//MEMORY CONTROLLER DESIGN
`timescale 1ns/10ps
module memory (DataBus, MemWr, MemRd, Addr);
  inout [63:0] DataBus;
  input MemWr, MemRd;
  input [5:0] Addr;
	reg [63:0] datareg;   // datareg is reg , for temporary storing the data from a particular memory location, From  datareg data will be fetched by the data bus
  reg [63:0] Mem [0:63];//memory declaration
 
  initial begin
	  $readmemh ("input.txt", Mem); // here we took some data, & we r directing dumping those data in the memory, here 'readmemh' is the system task to diump the data directly to the memory
	  $display($time,"ns data write process done ");  //$readmemh reads hexadecimal data. Data has to exist in a text file.
  end
  
  always @ (MemWr or MemRd or Addr or datareg) begin
    	if (MemWr==1'b1 && MemRd==1'b0) begin
				Mem [Addr] =DataBus;
				datareg=64'hzzzzzzzzzzzzzzzz;
	 	end
	 	else if (MemRd==1'b1)	begin
			datareg= Mem[Addr]; // while reading , wll store the data to data register , then from data register data transferred to data bus
  
          $display($time,"ns data read Address-%h is %h\n",
                   Addr,datareg);
 
          $display($time,"ns data bus data is %h\n",DataBus);
	 	end
	 	else
			datareg=64'hzzzzzzzzzzzzzzzz;
   end
  assign DataBus = datareg; // data transferred to data bus , 'assign' will do the reading process of data from data bus
  endmodule
