// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.28;

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

/// @custom:security-contact
/// @title A Simple ERC20 token contract
/// @author hoanm (https://github.com/hoanm)
contract SimpleERC20 is ERC20, ERC20Burnable, AccessControl, ERC20Permit {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    uint8 private _decimals;

    bool public isMintable;

    constructor(
        address recipient,
        address defaultAdmin,
        address minter,
        string memory name_,
        string memory symbol_,
        uint256 initialSupply,
        uint8 decimals_,
        bool isMintable_
    ) ERC20(name_, symbol_) ERC20Permit(name_) {
        isMintable = isMintable_;
        _decimals = decimals_;
        _mint(recipient, initialSupply * 10 ** decimals());
        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
        _grantRole(MINTER_ROLE, minter);
    }

    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) canMint {
        _mint(to, amount);
    }

    modifier canMint() {
        require(isMintable, "Minting is disabled");
        _;
    }
}
