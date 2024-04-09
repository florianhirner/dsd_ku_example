package multipler_pkg;

    // --------------------------------------------------------------------------
    // Type definitions
    // --------------------------------------------------------------------------

    // Length definitions for the cipher
    parameter DATA_LENGTH       = 64;
    parameter BLOCK_LENGTH      = 16;
    parameter LENGTH            = 16;

    typedef enum {
        idle, 
        init, 
        compute, 
        finish
    } state_t;

    // typedef logic [KEY_LENGTH-1:0] key_t;
    typedef logic [LENGTH-1:0] counter_t;

endpackage