var communitycurrencyContract = web3.eth.contract([{"constant":true,"inputs":[],"name":"getBudget","outputs":[{"name":"_getGoalDemurrage","type":"uint256"},{"name":"_getGoalCrowdFunding","type":"uint256"},{"name":"_getGoalCommunityHours","type":"uint256"},{"name":"_getGoalExpenses","type":"uint256"},{"name":"_getcommitCrowdFunding","type":"uint256"},{"name":"_getCommitCommunityHours","type":"int256"},{"name":"_getCommitExpenses","type":"uint256"},{"name":"_getRealDemurrage","type":"int256"},{"name":"_getRealCrowdFunding","type":"uint256"},{"name":"_getRealCommunityHours","type":"int256"},{"name":"_getRealExpenses","type":"uint256"},{"name":"_getCommuneBalance","type":"int256"},{"name":"_getTreasuryBalance","type":"int256"}],"type":"function"},{"constant":false,"inputs":[{"name":"_authorized","type":"address"}],"name":"accessMyWallet","outputs":[],"type":"function"},{"constant":true,"inputs":[{"name":"_monitored","type":"address"}],"name":"monitorWallet","outputs":[{"name":"_getCCUs","type":"int256"},{"name":"_getCredit","type":"uint256"},{"name":"_getDeadline","type":"uint256"},{"name":"_getMoneyLender","type":"address"},{"name":"_getUnitsOfTrust","type":"uint256"},{"name":"_getIsMember","type":"bool"},{"name":"_getAlias","type":"string"},{"name":"_getReputation","type":"uint256"},{"name":"_getLast","type":"uint256"},{"name":"_getGdpActivity","type":"uint256"},{"name":"_getCommitH","type":"int256"},{"name":"_getCommitF","type":"uint256"}],"type":"function"},{"constant":false,"inputs":[{"name":"_beneficiary","type":"address"},{"name":"_createReputation","type":"uint256"}],"name":"mintAssignReputation","outputs":[],"type":"function"},{"constant":false,"inputs":[{"name":"_createCCUs","type":"int256"}],"name":"mintCCUs","outputs":[],"type":"function"},{"constant":false,"inputs":[{"name":"_contractor","type":"address"},{"name":"_payE","type":"uint256"}],"name":"payExpenses","outputs":[],"type":"function"},{"constant":false,"inputs":[{"name":"_commitE","type":"uint256"}],"name":"commitExpenses","outputs":[],"type":"function"},{"constant":false,"inputs":[{"name":"_newExchange","type":"uint256"}],"name":"setExchange","outputs":[],"type":"function"},{"constant":false,"inputs":[{"name":"_NewGoalDemurrage","type":"uint256"},{"name":"_newGoalCrowdFunding","type":"uint256"},{"name":"_newGoalCommunityHours","type":"uint256"},{"name":"_newGoalExpenses","type":"uint256"}],"name":"setNewBudget","outputs":[],"type":"function"},{"constant":false,"inputs":[{"name":"_servant","type":"address"},{"name":"_payH","type":"uint256"}],"name":"payHours","outputs":[],"type":"function"},{"constant":false,"inputs":[],"name":"creditUpdate","outputs":[],"type":"function"},{"constant":false,"inputs":[{"name":"_commitF","type":"uint256"}],"name":"commitFunding","outputs":[],"type":"function"},{"constant":false,"inputs":[{"name":"_newMember","type":"address"},{"name":"_newAlias","type":"string"}],"name":"acceptMember","outputs":[],"type":"function"},{"constant":false,"inputs":[{"name":"_claimH","type":"int256"}],"name":"claimHours","outputs":[],"type":"function"},{"constant":false,"inputs":[{"name":"_newCommunity","type":"address"}],"name":"newCommune","outputs":[],"type":"function"},{"constant":false,"inputs":[{"name":"_newTreasury","type":"address"}],"name":"newTreasury","outputs":[],"type":"function"},{"constant":true,"inputs":[],"name":"getParameters","outputs":[{"name":"_getTreasury","type":"address"},{"name":"_getCommunity","type":"address"},{"name":"_getDemurrage","type":"int256"},{"name":"_getRewardRate","type":"uint256"},{"name":"_getIniMemberCCUs","type":"int256"},{"name":"_getIniMemberReputation","type":"uint256"},{"name":"_getExchange","type":"uint256"},{"name":"getName","type":"string"},{"name":"getSymbol","type":"string"},{"name":"getCommunityName","type":"string"},{"name":"getBaseUnits","type":"uint256"}],"type":"function"},{"constant":true,"inputs":[],"name":"getMoneyTotals","outputs":[{"name":"_getTotalMinted","type":"int256"},{"name":"_getTotalCredit","type":"uint256"},{"name":"_getTotalTrustCost","type":"uint256"},{"name":"_getTotalTrustAvailable","type":"uint256"}],"type":"function"},{"constant":false,"inputs":[{"name":"_payee","type":"address"},{"name":"_payment","type":"uint256"}],"name":"transfer","outputs":[],"type":"function"},{"constant":false,"inputs":[{"name":"_newDemurrage","type":"int256"},{"name":"_newRewardRate","type":"uint256"},{"name":"_newIniCCUs","type":"int256"},{"name":"_newIniR","type":"uint256"}],"name":"newParameters","outputs":[],"type":"function"},{"constant":false,"inputs":[{"name":"_oldMember","type":"address"}],"name":"kickOutMember","outputs":[],"type":"function"},{"constant":false,"inputs":[{"name":"_borrower","type":"address"},{"name":"_credit","type":"uint256"},{"name":"_daysAfter","type":"uint256"}],"name":"credit","outputs":[],"type":"function"},{"constant":false,"inputs":[{"name":"_commitH","type":"int256"}],"name":"commitHours","outputs":[],"type":"function"},{"constant":false,"inputs":[{"name":"_payF","type":"uint256"}],"name":"payFunding","outputs":[],"type":"function"},{"inputs":[],"type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"name":"_amount","type":"uint256"},{"indexed":true,"name":"_from","type":"address"},{"indexed":true,"name":"_to","type":"address"},{"indexed":false,"name":"_timeStampT","type":"uint256"}],"name":"Transfer","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"_creditCCUs","type":"uint256"},{"indexed":false,"name":"_creditDays","type":"uint256"},{"indexed":false,"name":"_endorsedUoT","type":"uint256"},{"indexed":true,"name":"_endorsedAddress","type":"address"},{"indexed":false,"name":"_myReputationBalance","type":"uint256"},{"indexed":false,"name":"_timeStampC","type":"uint256"}],"name":"Credit","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_hFrom","type":"address"},{"indexed":false,"name":"_claimedH","type":"int256"},{"indexed":false,"name":"_timeStampCH","type":"uint256"}],"name":"ClaimH","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_hTo","type":"address"},{"indexed":false,"name":"_paidH","type":"uint256"},{"indexed":false,"name":"_timeStampPH","type":"uint256"}],"name":"PaidH","type":"event"}]);

var communityCurrency = communitycurrencyContract.at("0xf025d81196b72fba60a1d4dddad12eeb8360d828");

web3.eth.defaultAccount = web3.eth.coinbase;

var coinbase = web3.eth.coinbase;

var myWallet = communityCurrency.monitorWallet(coinbase);
var myCommunityCUnits = myWallet[0];
var myCredit = myWallet[1];
var myDeadline = myWallet[2];
var myMoneyLender = myWallet[3];
var myUnitsOfTrust = myWallet[4];
var myIsMember = myWallet[5];
var myAlias = myWallet[6];
var myReputation = myWallet[7];
var myLast = myWallet[8];
var myGdpActivity = myWallet[9];
var myCommittedH = myWallet[10];
var myCommittedF = myWallet[11];

var contractParameters = communityCurrency.getParameters();
var treasury = contractParameters[0];
var commune = contractParameters[1];
var demurrage = contractParameters[2];
var rewardRate = contractParameters[3];
var iniMemberCCUs = contractParameters[4];
var iniMemberReputation = contractParameters[5];
var exchangeRate = contractParameters[6];
var name = contractParameters[7];
var symbol = contractParameters[8];
var communityName = contractParameters[9];
var baseUnits = contractParameters[10];

if (myIsMember = true) {
	var commoner ="Commoner of " +  communityName + " Community";
} else { 
    commoner ="Not Commoner";
	myAlias = "visitor";
};

var dateMyLast = new Date(myLast * 1000);
var dateMyDealine = new Date(myDeadline * 1000);


