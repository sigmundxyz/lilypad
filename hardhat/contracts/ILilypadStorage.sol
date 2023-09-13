// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.6;

import "./SharedStructs.sol";

interface ILilypadStorage {
  
  /**
   * Deals
   */

  function getDeal(
    uint256 dealId
  ) external returns (SharedStructs.Deal memory);

  function getDealsForParty(
    address party
  ) external returns (uint256[] memory);

  function ensureDeal(
    uint256 dealId,
    SharedStructs.DealMembers memory members,
    SharedStructs.DealTimeouts memory timeouts,
    SharedStructs.DealPricing memory pricing
  ) external returns (SharedStructs.Deal memory);

  /**
   * Agreements
   */

  function getAgreement(
    uint256 dealId
  ) external returns (SharedStructs.Agreement memory);
  
  function agreeResourceProvider(
    uint256 dealId
  ) external returns (SharedStructs.Agreement memory);

  function agreeJobCreator(
    uint256 dealId
  ) external returns (SharedStructs.Agreement memory);
  
  /**
   * Post Results
   */

  function getResult(
    uint256 dealId
  ) external returns (SharedStructs.Result memory);

  function addResult(
    uint256 dealId,
    uint256 resultsId,
    uint256 instructionCount
  ) external returns (SharedStructs.Result memory);

  /**
   * Judge Results
   */

  function acceptResult(
    uint256 dealId
  ) external;

  function checkResult(
    uint256 dealId,
    address mediator
  ) external;

  /**
   * Mediation
   */
  
  function mediationAcceptResult(
    uint256 dealId
  ) external;

  function mediationRejectResult(
    uint256 dealId
  ) external;

  /**
   * Timeouts
   */
  function timeoutAgree(
    uint256 dealId
  ) external;

  function timeoutSubmitResult(
    uint256 dealId
  ) external;

  function timeoutJudgeResult(
    uint256 dealId
  ) external;

  function timeoutMediateResult(
    uint256 dealId
  ) external;

  /**
   * Costings
   */

  function getJobCost(
    uint256 dealId
  ) external returns (uint256);

  function getResultsCollateral(
    uint256 dealId
  ) external returns (uint256);
  
  /**
   * Checkers
   */

  function hasDeal(
    uint256 dealId
  ) external returns (bool);

  function isState(
    uint256 dealId,
    SharedStructs.AgreementState state
  ) external returns (bool);
  
}
