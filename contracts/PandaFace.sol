pragma solidity ^0.5.8;

import "@openzeppelin/contracts/token/ERC20/ERC20Mintable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Pausable.sol";

/**
* Author SylTi
* Panda-Face Basic Implementation meant only for testnet.
* More granular access control can be added to further separate responsabilities between seizer(s) and minter(s).
* Token can be paused for emergency shutdown.
*/
contract PandaFace is ERC20Mintable, ERC20Pausable, ERC20Detailed("Panda-Face EUR", "PEUR", 2) {

  /**
  * @dev Emitted when `value` tokens are seized from one account (`from`) to
  * be sent to another (`to`).
  *
  * Note that `value` may be zero.
  */
  event Seized(address indexed from, address indexed to, uint256 value);

  /**
  * @dev Emitted when `value` tokens are burned from one account (`from`)
  *
  * Note that `value` may be zero.
  */
  event Burned(address indexed from, uint256 value);

  /**
  * @dev Seize tokens `amount` from `from` to `to`.
  *
  * This is a public function that can only be called by address having the minter privilege
  * Emits 2 events: {Transfer} and {Seized}
  *
  * Requirements:
  *
  * - `from` cannot be the zero address.
  * - `to` cannot be the zero address.
  * - `from` must have a balance of at least `amount`.
  */
  function seize(address from, address to, uint256 amount) public onlyMinter returns (bool) {
    _transfer(from, to, amount);
    emit Seized(from, to, amount);
    return true;
  }

  /**
  * @dev Burn tokens `amount` from `from`
  *
  * This is a public function that can only be called by address having the minter privilege
  * Emits 2 events: {Transfer} and {Burned}
  *
  * Requirements:
  *
  * - `from` cannot be the zero address.
  * - `from` must have a balance of at least `amount`.
  */
  function burn(address from, uint256 amount) public onlyMinter returns (bool) {
    _burn(from, amount);
    emit Burned(from, amount);
    return true;
  }
}