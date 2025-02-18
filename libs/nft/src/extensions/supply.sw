library;

pub mod supply_errors;
pub mod supply_events;

use ::nft_core::nft_storage::MAX_SUPPLY;
use std::storage::storage_api::{read, write};
use supply_errors::SupplyError;
use supply_events::SupplyEvent;

abi Supply {
    #[storage(read)]
    fn max_supply() -> Option<u64>;
    #[storage(read, write)]
    fn set_max_supply(supply: Option<u64>);
}

/// Returns the maximum supply that has been set for the NFT library.
///
/// # Number of Storage Accesses
///
/// * Reads: `1`
#[storage(read)]
pub fn max_supply() -> Option<u64> {
    read::<Option<u64>>(MAX_SUPPLY, 0).unwrap_or(Option::None)
}

/// Sets the maximum supply for the NFT library.
///
/// # Arguments
///
/// * `supply` - The maximum number fo tokens which may be minted
///
/// # Number of Storage Accesses
///
/// * Reads: `1`
/// * Writes: `1`
///
/// # Reverts
///
/// * When the supply has already been set
#[storage(read, write)]
pub fn set_max_supply(supply: Option<u64>) {
    let current_supply = read::<Option<u64>>(MAX_SUPPLY, 0).unwrap_or(Option::None);
    require(current_supply.is_none(), SupplyError::CannotReinitializeSupply);

    write(MAX_SUPPLY, 0, supply);

    log(SupplyEvent { supply });
}
