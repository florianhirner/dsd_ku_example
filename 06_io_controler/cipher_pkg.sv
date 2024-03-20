package cipher_pkg;

    // --------------------------------------------------------------------------
    // Type definitions
    // --------------------------------------------------------------------------

    // Length definitions for the cipher
    parameter KEY_LENGTH  = 128;
    parameter DATA_LENGTH = 128;
    parameter LENGTH      = 32;

    typedef enum {
        idle, 
        init, 
        read_ad, 
        read_ad_check,  
        read_data, 
        compute, 
        write_data, 
        write_tag, 
        finish
    } state_t;

    typedef logic [KEY_LENGTH-1:0] key_t;

endpackage