// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./SimpleERC20.sol";

/// @custom:security-contact
/// @title A Simple ERC20 token contract
/// @author hoanm (https://github.com/hoanm)
contract ERC20Factory {
    // Event emitted when a new token is created
    event TokenCreated(
        address tokenAddress, string name, string symbol, uint8 decimals, uint256 initialSupply, address owner
    );

    constructor() {}

    /**
     * @dev Creates a new ERC20 token WITHOUT the initial supply
     * @dev The token is owned by the caller of this function
     * @dev The minter is the caller of this function
     * @dev Decimals is set to 18
     * @dev The token must be mintable by default
     * @param name_ The name of the token
     * @param symbol_ The symbol of the token
     * @return The address of the newly created token
     */
    function createToken(string memory name_, string memory symbol_) external returns (address) {
        // Create a new token with the provided parameters
        SimpleERC20 newToken = new SimpleERC20(msg.sender, msg.sender, msg.sender, name_, symbol_, 0, 18, true);

        // Store the token address
        address tokenAddress = address(newToken);

        // Emit event
        emit TokenCreated(tokenAddress, name_, symbol_, 18, 0, msg.sender);

        return tokenAddress;
    }

    /**
     * @dev Creates a new ERC20 token WITH the initial supply
     * @dev The token is owned by the caller of this function
     * @dev The minter is the caller of this function
     * @dev Decimals is set to 18
     * @param name_ The name of the token
     * @param symbol_ The symbol of the token
     * @param recipient The address to receive the initial supply of tokens
     * @param initialSupply The initial supply of tokens to be minted
     * @param isMintable Whether the token is mintable or not
     * @return The address of the newly created token
     */
    function createTokenWithInitialSupply(
        string memory name_,
        string memory symbol_,
        address recipient,
        uint256 initialSupply,
        bool isMintable
    ) external returns (address) {
        // Create a new token with the provided parameters
        SimpleERC20 newToken =
            new SimpleERC20(recipient, msg.sender, msg.sender, name_, symbol_, initialSupply, 18, isMintable);

        // Store the token address
        address tokenAddress = address(newToken);

        // Emit event
        emit TokenCreated(tokenAddress, name_, symbol_, 18, initialSupply, msg.sender);

        return tokenAddress;
    }

    /**
     * @dev Creates a new ERC20 token WITH the initial supply
     * @dev The token is owned by the caller of this function
     * @dev The minter is the caller of this function
     * @param name_ The name of the token
     * @param symbol_ The symbol of the token
     * @param decimals_ The number of decimals for the token
     * @param recipient The address to receive the initial supply of tokens
     * @param initialSupply The initial supply of tokens to be minted
     * @param isMintable Whether the token is mintable or not
     * @return The address of the newly created token
     */
    function createTokenWithInitialSupplyAndDecimals(
        string memory name_,
        string memory symbol_,
        uint8 decimals_,
        address recipient,
        uint256 initialSupply,
        bool isMintable
    ) external returns (address) {
        // Create a new token with the provided parameters
        SimpleERC20 newToken =
            new SimpleERC20(recipient, msg.sender, msg.sender, name_, symbol_, initialSupply, decimals_, isMintable);

        // Store the token address
        address tokenAddress = address(newToken);

        // Emit event
        emit TokenCreated(tokenAddress, name_, symbol_, decimals_, initialSupply, msg.sender);

        return tokenAddress;
    }
}
