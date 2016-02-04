contract communityCurrency {
	
	// @title Community Currency
	// @author Rogelio SEGOVIA	
	// @notice register 
	// @param name the name of the currency
	// @param symbol the symbol of the currency
	// @param baseUnits is the number of units before the comma 
    string public name;
    string public symbol;
	string public communityName;
    uint public baseUnits;
	
	// @notice communityCurrency general variables
    // @param _treasury the address of the treasury of the DAO. The creator and minter of the currency
    // @param _community the address of the Community account. Where donations and taxes are paid. Account used to pay community works
    // @param _demurrage the depreciation at each transaction. The demurrage to be paid to the DAO at the community account. % x 100
    // @param _rewardRate reward Rate to the moneyLender of a successful credit, as a multiplier of the Reputation Cost of the credit. % x 100
    // @param _iniMemberCCUs initial Community Currency Units given to any new member. The monetary mass is automatically increased with any new member
    // @param _iniMemberReputation initial Reputation given to any new member
	// @param _exchange is the exchange rate in EUROS per Community Currency units
    address _treasury; 
	address _community;  
	int _demurrage; 
	uint _rewardRate; 
	int _iniMemberCCUs; 
	uint _iniMemberReputation;
	uint _exchange;
	//@notice Budget array
		uint _goalDemurrage;
		uint _goalCrowdFundig;
		uint _goalCommunityHours;
		uint _goalExpenses;
		uint _committedDemurrage;
		uint _committedCrowdFundig;
		uint _committedCommunityHours;
		uint _committedExpenses;
		uint _realDemurrage;
		uint _realCrowdFundig;
		uint _realCommunityHours;
		uint _realExpenses;
	
	// @notice communityCurrency parameters and key addresses for a given Community	
	function communityCurrency () {
		_treasury = msg.sender;  
		_community = msg.sender; 
		_demurrage = 3;
		_rewardRate = 20;
		_iniMemberCCUs = 2500;
		_iniMemberReputation = 12500;
		_exchange = 10;
		name = "HOUR";
		symbol = "HR";
		communityName = "DESPERADO";
		baseUnits = 100;
	}
	
	// @notice structure the members wallet
	// @param _communityCUnits is the actual balance of the currency CCs in the Wallet of the account. It can be negative!!!	
	// @param _credit is the limit of _communityCUnits the account is authorized to become negative
	// @param _deadline is the time limit on which the credit should be already cancelled and becomes zero again
	// @param _moneyLender is the address of the money lender. The credit line authorizer
	// @param _unitsOfTrust is the cost in reputation (Units of Trust) of credit line the account has been authorized. The Trust endorsed to this account by the money lender. It is calculated in terms of credit volume = time x amountCCs
	// @param _isMember boolean if it is an accepted member
	// @param _alias is a string with the alias or ID of the member
	// @param _reputation is the volume of the credit in terms of balance of Units of Trust the money lender can authorize; that is, his available balance in Units of Trust he may endorse to others 
	// @param _last time stamp of the last transaction
	// @param _gdpActivity measures the average economic activity of the account in a time period. It measures the monetary mass moved by an account as m x v
	struct communityCurrencyWallet {
		int _communityCUnits; 
		uint _credit; 
		uint _deadline; 
		address _moneyLender; 
		uint _unitsOfTrust; 
		bool _isMember; 
		string _alias; 
		uint _reputation; 
		uint _last; 
		uint _gdpActivity; 
		int _committedH;
		uint _committedF;
	}
	
	mapping (address => communityCurrencyWallet) balancesOf;	
	
	event Transfer(uint _amount, address indexed _from, address indexed _to, uint _timeStampT);
	event Credit(uint _creditCCUs, uint _creditDays, uint _endorsedUoT, address indexed _endorsedAddress, uint _myReputationBalance, uint _timeStampC);

	// @notice the community account can accept accounts as members. The Community should ensure the unique correspondence to a real person 
	// @notice a community can opt to name itself member or not and therefore give credits or not
	// @param _newMember is the address of the new member
	// @param _newAlias is the alias or human readable ID of the new member
	// @return changed alias, initial balance in CCUs, initial reputation in UoT
	function acceptMember (address _newMember, string _newAlias) {
        if (msg.sender != _community) return;
        balancesOf[_newMember]._isMember = true;
		balancesOf[_newMember]._alias = _newAlias;
        balancesOf[_newMember]._communityCUnits = _iniMemberCCUs;
        balancesOf[_newMember]._reputation = _iniMemberReputation;
        balancesOf[_newMember]._last = now;
    }
	// @notice the community account can kick out members. The action deletes all balances
	// @param _oldMember is the address of the member to be kicked out
	// @return isMember turned to false, all other account balances to zero, except _communityCUnits
	function kickOutMember (address _oldMember) {
        if (msg.sender != _community) return;
        balancesOf[_oldMember]._isMember = false;
        balancesOf[_oldMember]._reputation = 0;
        balancesOf[_oldMember]._credit = 0;
        balancesOf[_oldMember]._deadline = 0;
        balancesOf[_oldMember]._last = block.number;
    }

	// @notice the treasury account can change the currency parameters
	// @param _newDemurrage is the new demurrage rate. % x 100
	// @param _newrewardRate is the new reward rate for successful credits. % x 100
	// @param _newIniCCUs is the new initial Community Currency Units given to any new member
	// @param _newIniR is the new initial Reputation given to any new member
	// @return new demurrage, reward rate, initial CCUs and initial reputation for new members
	function newParameters (int _newDemurrage, uint _newrewardRate, int _newIniCCUs, uint _newIniR) {
		if (msg.sender != _treasury) return;
		_demurrage = _newDemurrage;
		_rewardRate = _newrewardRate;
		_iniMemberCCUs = _newIniCCUs;
		_iniMemberReputation = _newIniR;
	}
	
	// @notice the treasury account can change to a new community address
	// @param _newCommunity is the new address holding the Community permissions
	// @return new community address
	function newCommunity (address _newCommunity) {
		if (msg.sender != _treasury) return;
		_community = _newCommunity;
	}
	
	// @notice the community account can change to a new treasury address
	// @param _newTreasury is the new address holding the Community permissions
	// @return new treasury address
	function newTreasury (address _newTreasury) {
		if (msg.sender != _community) return;
		_treasury = _newTreasury;
	}
	
	// @notice the treasury account can issue as much communityCurrency it likes and send it to the Community account 
	// @notice it mints new communityCurrency and thus increases the monetary mass
	// @notice it can be negative, taking money from the Community account and destroying it, thus diminishing the total monetary mass
	// @param _createCCUs is the amount of CCUs to be created or destroyed
	// @return more (or less) money in the community account
	function mintCCUs (int _createCCUs) {
        if (msg.sender != _treasury) return;
		balancesOf[_community]._communityCUnits += _createCCUs;
	}

	// @notice the community account can issue as much Reputation it likes and send it to any Member; it can mint Reputation
	// @param _beneficiary is the address of the beneficiary
	// @param _createReputation is the amount of reputation to be allocated; it is always positive
	// @return more reputation in somebody account
	function mintAssignReputation (address _beneficiary, uint _createReputation) {
        if (msg.sender != _community) return;
		if (balancesOf[_beneficiary]._isMember != true) return;
        balancesOf[_beneficiary]._reputation += _createReputation;
    }

	function creditUpdate () {
		// @notice update the credit status
		if (balancesOf[msg.sender]._credit > 0) {
		// @notice check if deadline is over
			if (now >= balancesOf[msg.sender]._deadline) {
			// @notice if time is over reset credit to zero, deadline to zero
				balancesOf[msg.sender]._deadline = 0;
				balancesOf[msg.sender]._credit = 0;
				// @notice if balance is negative the credit was not returned, the money lender balanceReputation is not restored and is penalized with a 20%
				// @notice as regards the borrower will not be able to make any new transfer until future incomes cover the debts
				// @return money lender reputation penalized
				if (balancesOf[msg.sender]._communityCUnits < 0) {
					balancesOf[balancesOf[msg.sender]._moneyLender]._reputation -= balancesOf[msg.sender]._unitsOfTrust * _rewardRate/100;
				}
				// @notice if balance is not negative the credit was returned, the money lender balanceReputation is restored and is rewardRateed with a 20%
				// @return money lender reputation rewarded
				else {
					balancesOf[balancesOf[msg.sender]._moneyLender]._reputation += balancesOf[msg.sender]._unitsOfTrust * (100 + _rewardRate)/100;
				}
				// @notice reset money lender information
				// @return money lender information deleted
				balancesOf[msg.sender]._moneyLender = msg.sender; 
				balancesOf[msg.sender]._unitsOfTrust = 0;
		// @notice if time is not over proceed with the payment
			} 
		}
	}
			

	// @notice function make a payment
	// @notice anybody with an ethereum account can make a payment if he has sufficient CCUs in the balance
	// @notice any member can add to the amount available at the balance, what remains unused in the credit line
	// @param _payee is the account to be credited
	// @param _payment is the amount in CCUs to be send
	// @return balance of payee increased
	// @return balance of sender decreased
	// @return in case of need, available credit decreased	
	function transfer (address _payee, uint _payment) {
	// @return credit information updated
		creditUpdate ();
	// @notice pay with the CCUs available at the balance and the credit
		int _creditLine = int(balancesOf[msg.sender]._credit);
		// @param _available is the spending limit of an account, given the account balance in _communityCUnits and the _credit
		int _available = balancesOf[msg.sender]._communityCUnits + _creditLine; 
		int _amountCCUs = int(_payment); 
		if (_available > _amountCCUs) {
			balancesOf[msg.sender]._communityCUnits -= _amountCCUs;
			balancesOf[_payee]._communityCUnits += _amountCCUs;
			// @notice apply demurrage and send it to the Community account
			balancesOf[_payee]._communityCUnits -= _amountCCUs * _demurrage/100;
			balancesOf[_community]._communityCUnits += _amountCCUs * _demurrage/100;
			Transfer(_payment, msg.sender, _payee, now);
	// @notice update the Activity indicator
			balancesOf[msg.sender]._gdpActivity = (balancesOf[msg.sender]._gdpActivity * balancesOf[msg.sender]._last + _payment)/now;
			balancesOf[msg.sender]._last = 1000 * now;
		}
	}
	

	// @notice function authorize a credit
	// @notice only members can authorize or get a credit
	// @param _borrower is the address of the credit borrower
	// @param _credit is the amount of the credit line in CCUs
	// @param _daysAfter is the deadline of the credit line in number of days from today
	function credit(address _borrower, uint _credit, uint _daysAfter)  {
		if (balancesOf[msg.sender]._isMember != true) return;
		if (balancesOf[_borrower]._isMember != true) return;
		if (balancesOf[_borrower]._credit > 0) return;
			uint _unitsOfTrust = _credit * _daysAfter;
			if (balancesOf[msg.sender]._reputation > _unitsOfTrust) {
				balancesOf[msg.sender]._reputation -= _unitsOfTrust;
				balancesOf[_borrower]._credit += _credit;
				balancesOf[_borrower]._moneyLender = msg.sender;
				// @notice the _deadline is established as a number of days ahead
				balancesOf[_borrower]._deadline = now + _daysAfter * 1 days; 
				balancesOf[_borrower]._unitsOfTrust = _unitsOfTrust;
				Credit(_credit, _daysAfter, balancesOf[_borrower]._unitsOfTrust, _borrower, balancesOf[msg.sender]._reputation, now);
				}
	}
	
  	// @notice monitor Wallet
  	// @notice the borrower candidate has given access to monitor all relevant parameters of his account to the money lender
	// @notice the community can also monitor all accounts
	// @dev if you want to disallow the community to monitor all accounts delete the OR | (msg.sender == _community) |
	// @param _monitored is the address to be monitored
	// @return _getCCUs is the balance in CCUs 
	// @return _getCredit is the remaining credit
	// @return _getDeadline is the credit deadline
	// @return _getMoneyLender is the address of the current money lender or the candidate money lender
	// @return _getUnitsOfTrust is the cost in reputation of the credit
	// @return _getIsMember is boolean if the account is a member
	// @return _getAlias is the alias
	// @return _getReputation is the reputation in UoTs
	// @return _getLast is the date of the last transaction
	// @return _getGdpActivity is the average activity
	function monitorWallet(address _monitored) constant returns (int _getCCUs, uint _getCredit, uint _getDeadline, address _getMoneyLender, uint _getUnitsOfTrust, bool _getIsMember, string _getAlias, uint _getReputation, uint _getLast, uint _getGdpActivity  ) {
		if ((_monitored == msg.sender) || (msg.sender == _community) || (msg.sender == balancesOf[_monitored]._moneyLender)) {
    	_getCCUs = balancesOf[_monitored]._communityCUnits;	
		_getCredit = balancesOf[_monitored]._credit;
		_getDeadline = balancesOf[_monitored]._deadline;
		_getMoneyLender = balancesOf[_monitored]._moneyLender;
		_getUnitsOfTrust = balancesOf[_monitored]._unitsOfTrust;
		_getIsMember = balancesOf[_monitored]._isMember;
		_getAlias = balancesOf[_monitored]._alias;
		_getReputation = balancesOf[_monitored]._reputation;
		_getLast = balancesOf[_monitored]._last;
		_getGdpActivity = balancesOf[_monitored]._gdpActivity;
		}
    	}

   // @notice get the currency parameters
	function getParameters() constant returns (address _getTreasury, address _getCommunity, int _getDemurrage, uint _getRewardRate, int _getIniMemberCCUs, uint _getIniMemberReputation, uint _getExchange, string getName, string getSymbol, string getCommunityName, uint getBaseUnits) {
		_getTreasury = _treasury;
		_getCommunity = _community;
		_getDemurrage = _demurrage;
		_getRewardRate = _rewardRate;
		_getIniMemberCCUs = _iniMemberCCUs;
		_getIniMemberReputation = _iniMemberReputation;
		_getExchange = _exchange;
		getName = name;
		getSymbol = symbol;
		getCommunityName = communityName;
		getBaseUnits = baseUnits;		
	}
	
   // @notice authorize monitoring
   function accessMyWallet (address _authorized) {
	   // @notice during a credit, only the money lender and the community have access
	   // @notice normally, the authorization to monitor own accounts is given to a candidate money lender
	   if (balancesOf[msg.sender]._credit != 0) return;
	   balancesOf[msg.sender]._moneyLender = _authorized;
   }
	
	//@notice committ Hours
	function commitHours (int _commitH) {
		balancesOf[msg.sender]._committedH += _commitH;		
	}
	
	//@notice get Hours paid from Community
	function payHours (int _payH) {
		if (balancesOf[msg.sender]._committedH > _payH) {
			balancesOf[msg.sender]._committedH -= _payH;
			//@notice Community always pays, even going negative
			balancesOf[_community]._communityCUnits -= _payH;
			balancesOf[msg.sender]._communityCUnits += _payH;
		}
	}
	
	//@notice committ Funding
	function commitFunding (uint _commitF) {
		balancesOf[msg.sender]._committedF += _commitF;		
	}
	
	//@notice pay Funding
	function payFunding (uint _payF) {
		transfer (_community, _payF);
	}
	
}
