import lc3b_types::*;

module cache_datapath (
    input clk,
    output lc3b_word mem_rdata,
    input lc3b_word mem_address,

    input lc3b_pmem_line pmem_rdata,

    input load_set_one,
    input load_set_two,

    output hit,

    output set_one_hit,
    output set_two_hit
);

logic hit_sig;

cache_block main_block (
    .clk(clk),
    .cache_addr(mem_address),
    .hit(hit_sig),
    .out_data_block(mem_rdata)
    .load_set_one(load_set_one),
    .load_set_two(load_set_two),
    .input_data(pmem_rdata)
    .set_one_hit(set_one_hit),
    .set_two_hit(set_two_hit)
);

assign hit = hit_sig;

endmodule : cache_datapath