pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/ERC20Mintable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Pausable.sol";

/**
* Author SylTi
* Panda-Face Basic Implementation meant only for testnet.
* More granular access control can be added to further separate responsabilities between seizer(s) and minter(s).
* Token can be paused for emergency shutdown.
*/
contract PandaFace is ERC20Mintable, ERC20Pausable, ERC20Detailed {
  /**
  * @dev Emitted when `value` tokens are seized from one account (`from`) to
  * be sent to another (`to`).
  *
  * Note that `value` may be zero.
  */
  event Seized(address indexed from, address indexed to, uint256 value);

  /**
    * @dev Seize tokens `amount` from `from` to `to`.
    *
    * This is a public function that can only be called by address having the minter privilege
    * Emits 2 events: {Transfer} and {Seized}
    *
    * Requirements:
    *
    * - `sender` cannot be the zero address.
    * - `recipient` cannot be the zero address.
    * - `sender` must have a balance of at least `amount`.
    */
  function seize(address from, address to, uint256 amount) public onlyMinter returns (bool) {
    _transfer(from, to, amount);
    emit Seized(from, to, amount);
    return true;
  }
}