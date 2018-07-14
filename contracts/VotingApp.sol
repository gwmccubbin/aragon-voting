pragma solidity ^0.4.4;

import "@aragon/os/contracts/apps/AragonApp.sol";
import "@aragon/os/contracts/lib/zeppelin/math/SafeMath.sol";

contract VotingApp is AragonApp {
    using SafeMath for uint256;

    // Events
    event Increment(address indexed entity, uint256 step);
    event Decrement(address indexed entity, uint256 step);
    event VotePass();

    // Tracks the vote
    // TODO: make this signed
    uint256 public value;
    // Voting Increment
    uint256 public step;
    // Threshold
    uint256 public goal = 10;
    // Tracks accounts that have voted
    mapping(address => bool) public voters;
    // Tracks vote passed
    bool public votePassed;

    /// ACL
    bytes32 constant public VOTING_ROLE = keccak256("VOTING_ROLE");

    /**
     * @notice Decrement the counter by `step`
    */
    function incrementVote() auth(VOTING_ROLE) external {
        // require(!voters[msg.sender]);
        // require(!votePassed);

        value = value.add(step);

        Increment(msg.sender, step);

        if(value >= goal) {
            votePassed = true;
            VotePass();
            // TODO: Forward an action here...
        }
    }

    /**
     * @notice Decrement the counter by `step`
     */
    function decrementVote() auth(VOTING_ROLE) external {
        // require(!voters[msg.sender]);
        // require(!votePassed);

        value = value.sub(step);

        Decrement(msg.sender, step);
    }
}
