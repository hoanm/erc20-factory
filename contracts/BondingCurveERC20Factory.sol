// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./SimpleBondingCurveERC20.sol";

/// @custom:security-contact
/// @title A Simple ERC20 token contract
/// @author hoanm (https://github.com/hoanm)
contract BondingCurveERC20Factory {
    // Event emitted when a new token is created
    event TokenCreated(
        address indexed tokenAddress, string name, string symbol, uint8 decimals, uint256 initialSupply, address native
    );

    constructor() {}

    /**
     * @dev Creates a new ERC20 token WITH the initial supply
     * @dev The token is owned by the caller of this function
     * @dev The minter is the caller of this function
     * @param name_ The name of the token
     * @param symbol_ The symbol of the token
     * @param decimals_ The number of decimals for the token
     * @param initialSupply_ The initial supply of tokens to be minted
     * @param wNative_ The address of native token
     * @return The address of the newly created token
     */
    function createTokenWithInitialSupplyAndDecimals(
        string memory name_,
        string memory symbol_,
        uint8 decimals_,
        uint256 initialSupply_,
        address wNative_
    ) external returns (address) {
        // Create a new token with the provided parameters
        SimpleBondingCurveERC20 newToken =
            new SimpleBondingCurveERC20(name_, symbol_, decimals_, initialSupply_, wNative_);

        // Store the token address
        address tokenAddress = address(newToken);

        // Emit event
        emit TokenCreated(tokenAddress, name_, symbol_, decimals_, initialSupply_, wNative_);

        return tokenAddress;
    }
}
