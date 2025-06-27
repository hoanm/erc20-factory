// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.28;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

/// @custom:security-contact
/// @title A Simple ERC20 token contract
/// @author hoanm (https://github.com/hoanm)
contract SimpleBondingCurveERC20 is ERC20, ERC20Burnable, ERC20Permit {
    uint8 private _decimals;

    address public wNative;

    constructor(string memory name_, string memory symbol_, uint8 decimals_, uint256 _initialSupply, address _wNative)
        ERC20(name_, symbol_)
        ERC20Permit(name_)
    {
        _decimals = decimals_;
        _mint(address(this), _initialSupply * 10 ** decimals());

        wNative = _wNative;
    }

    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }

    function buyExactIn(uint256 nativeTokenAmount, uint256 minReceiveAmount) external returns (uint256, uint256) {
        IERC20(wNative).transferFrom(msg.sender, address(this), nativeTokenAmount);

        // For testing, we fix the ratio is 1:2
        uint256 amountOut = nativeTokenAmount * 2;

        require(amountOut >= minReceiveAmount, "INSUFFICIENT_OUTPUT_AMOUNT");

        // transfer token to user
        IERC20(address(this)).transfer(msg.sender, amountOut);

        return (nativeTokenAmount, amountOut);
    }

    /**
     * @dev Allows users to sell bonded tokens to receive base tokens
     * @param tokenAmount Amount of bonded tokens to sell
     * @param minReceiveAmount Minimum amount of native tokens to receive
     * @return Amount of base tokens received (after fee deduction)
     */
    function sellExactIn(uint256 tokenAmount, uint256 minReceiveAmount) external returns (uint256, uint256) {
        IERC20(address(this)).transferFrom(msg.sender, address(this), tokenAmount);

        uint256 amountOut = tokenAmount / 2;

        require(amountOut >= minReceiveAmount, "INSUFFICIENT_OUTPUT_AMOUNT");

        // transfer token to user
        IERC20(wNative).transfer(msg.sender, amountOut);

        return (tokenAmount, amountOut);
    }
}
