/*
/// Module: my_nft
module my_nft::my_nft;
*/

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions

module my_nft::my_nft {
    use std::string;                  
    use sui::url::{Self, Url};

    // NFT struct
    public struct NFT has key, store {
        id: UID,
        name: string::String,
        description: string::String,
        url: Url,
    }

    // Create  NFT and send it to caller
    public fun mint(
        name: vector<u8>,
        description: vector<u8>,
        url: vector<u8>,
        ctx: &mut TxContext
    ) {
        let nft = NFT {
            id: object::new(ctx),
            name: string::utf8(name),
            description: string::utf8(description),
            url: url::new_unsafe_from_bytes(url),
        };
        let sender = tx_context::sender(ctx);
        
        transfer::public_transfer(nft, sender);  }

    // Transfer NFT to someone
    public fun transfer(nft: NFT, recipient: address) {
        transfer::public_transfer(nft, recipient);
    }
}  
