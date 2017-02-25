import lc3b_types::*;

module cache (
    input clk,

    /* Memory signals from cpu */
    output mem_resp,
    output lc3b_word mem_rdata,
    input mem_read,
    input mem_write,
    input lc3b_mem_wmask mem_byte_enable,
    input lc3b_word mem_address,
    input lc3b_word mem_wdata,

    /* Memory signals from main memory */
    input pmem_resp,
    input lc3b_pmem_line pmem_rdata,
    output pmem_read,
    output pmem_write,
	 
    output lc3b_pmem_addr pmem_address,
    output lc3b_pmem_line pmem_wdata
);

logic load_set_one;
logic load_set_two;

logic set_one_hit;
logic set_two_hit;

logic load_lru;
logic current_lru;

logic set_one_valid;
logic set_two_valid;
logic cache_in_mux_sel;

logic hit;

logic write_type_set_one;
logic write_type_set_two;

cache_datapath cdp(
    .clk(clk),
    .mem_rdata(mem_rdata),
    .mem_address(mem_address),

    .pmem_rdata(pmem_rdata),

    .load_set_one(load_set_one),
    .load_set_two(load_set_two),

    .mem_wdata(mem_wdata),

    .set_one_hit(set_one_hit),
    .set_two_hit(set_two_hit),

    .load_lru(load_lru),
    .current_lru(current_lru),

    .set_one_valid(set_one_valid),
    .set_two_valid(set_two_valid),
	 .hit(hit),
	 .cache_in_mux_sel(cache_in_mux_sel),
	 .write_type_set_one(write_type_set_one),
	 .write_type_set_two(write_type_set_two)
);

cache_control ccl(
    .clk(clk),

    /* Memory signals from cpu */
    .mem_resp(mem_resp),
    .mem_read(mem_read),
	 .mem_write(mem_write),

    /* Memory signals to/from main memory */
    .pmem_resp(pmem_resp),
    .pmem_read(pmem_read),
    .pmem_write(pmem_write),

    .load_set_one(load_set_one),
    .load_set_two(load_set_two),

    .set_one_hit(set_one_hit),
    .set_two_hit(set_two_hit),

    .load_lru(load_lru),
    .current_lru(current_lru), 

    .set_one_valid(set_one_valid),
    .set_two_valid(set_two_valid),

    .hit(hit),
	 
	 .cache_in_mux_sel(cache_in_mux_sel),
	 .write_type_set_one(write_type_set_one),
	 .write_type_set_two(write_type_set_two)
);


/* Unconditionally forward the memory address, we will always be using it for write and reads anyway
// Ok.. so its not unconditionally, we need to clear out the bottom 3 bits because those are used for offset*/
always_comb begin
	pmem_address = (mem_address & 16'b1111111111111000);
end

endmodule : cache