#Community-Currency
A community currency **template** with zero reserve mutual credit and adjustable parameters  
Blockchain transactions at https://live.ether.camp/account/d870e20d6b2ad29a3a68f6a3ddd27d6a79bd61a2  
JSON at https://live.ether.camp/account/d870e20d6b2ad29a3a68f6a3ddd27d6a79bd61a2/contract 

#Purpose  
This is not intended to be a global currency. It is intended to become an ecosystem of community currencies using this template, each of them with different parameters according to the needs of each community.  
The type of community we mean is local communities (for example a municipality) or communities with charitable, service, participatory or empowering orientation, that run mixed economies with **free market** combined with community **public budget** and public redistributive works. Examples can be local authorities, social movements associations, social economy businesses, workers unions, etc. It includes therefore an (optional) *taxation* function. Each community is supposed to name their currency with a different name. 

#Currency Governance and monetary decision process
We decouple the contract running the decision process in a supposed DAO and the currency contract running the monetary mechanics.
The DAO may use whatever more or less traditional or more or less innovative democracy to take decisions.   
The community is supposed to be managed by a DAO at ethereum or outside ethereum, or just run by a DAO using handwritten notebooks or any eGovernance software. The currency contract does not cover how the DAO is managed, the voting and decision mechanisms.   
Once the DAO has taken the main monetary decisions it passes the wished parameters to the currency contract through the two accounts allowed to change the settings of the currency: the **treasury** account and the **community** account.
At creating the currency contract you may set who they are.  
The currency design presumes that all monetary decisions of the community are implemented through two trusted accounts:
* the **treasury** account. Creates the currency, sets the basic parameters and deploys it to the blockchain. It can mint and assign amounts of **CCUs** (Community Currency Units).
* the **community** account. Admits or kicks out members. It can mint and assign amounts of **Reputation**. 
**Users** making a transfer can be anybody having an ethereum account. 
**Members**, additionally, can authorize credits to other members. Anybody, including Members, may have different ethereum accounts. The community is supposed to have external mechanisms to establish the **identity** of a person, and therefore establish which of his accounts this person prefers to use as the unique account as member. 

#Background   
- [What the hell is p2p credit](http://desperado-theory.blogspot.be/2015/05/what-hell-is-p2p-credit.html) at DESPERADOS THEORY blog  
- [Moneda con pagos y creditos p2p sin reserva](http://desperado-theory.blogspot.com.es/2015/08/moneda-con-pagos-y-creditos-p2p-sin.html) at DESPERADOS THEORY blog  
- [Apuntes sobre la soberania monetaria](http://www.monedasocial.org/apuntes-soberania-monetaria/) at Instituto de la Moneda Social  

#General  
The currency is supposed to be used within a community. Nevertheless, the currency can be used by anybody having an ethereum account to perform standard payment transactions. Whith regards payments it works as any other free market monetary token. Nevertheless, anybody using the currency pays a VAT for every transaction to the community, but no other taxes.   
Within the community, the members have additional obligations and benefits. They can be endorsed with **Trust** by peer members to get credit lines. 


#p2p Credits  
Members have a **Reputation** as "Money Lenders". Members can authorise a p2p Credit to another member, with a deadline. Its up to the Money Lender to investigate the borrowers solvency. No algorithm is provided within the currency contract to analyze the solvency. Just an activity indicator.   
Once the credit is approved the system generates the necessary Community Currency Units and adds them to the CCUs balance of the borrower. The Money Lender pays with a reputation cost measured in endorsed **Units of Trust**. The Units of Trust needed to endorse the credit is proportional to the amount and the time of the credit.   
When the deadline is over:
* if the credit has been returned, and the balance of the borrower is again positive, the Money Lender gets back the Reputation Cost and a reward in Reputation. In the future he will be able to authorize larger credits.
* if the credit has not been returned, and the balance of the borrower is still negative, the Money Lender loses the Reputation Cost and a fine in Reputation. In the future he will be able to authorize only smaller credits. The borrower gets the account blocked until the debt is covered by future incomes. The Community has the option to kick this member out. 

#Adjustable Parameters
- **treasury**; the address of the treasury of the DAO. The creator and minter of the currency  
- **community**; the address of the Community account. Where donations and taxes are paid. Account used to pay community works  
- **vatRate**; the depreciation at each transaction. The VAT to be paid to the DAO at the community account. % x 100  
- *demurrage*; a periodic depreciation on the monetary assets. Not used. Judged as unwanted   
- **rewardRate**; reward Rate to the moneyLender of a successful credit, as a multiplier of the Reputation Cost of the credit. % x 100  
- **iniMemberCCUs**; initial Community Currency Units given to any new member. The monetary mass is automatically increased with any new member. By default, the total monetary mass is proportional to the number of members
- **iniMemberReputation**; initial Reputation given to any new member


#Functions
##function acceptMember
the community account can accept accounts as members. The Community should ensure the unique correspondence to a real person 
a community can opt to name itself member or not and therefore give credits or not
_newMember is the address of the new member
_newAlias is the alias or human readable ID of the new member
changed alias, initial balance in CCUs, initial reputation in UoT
##function kickOutMember 
the community account can kick out members. The action deletes all balances
_oldMember is the address of the member to be kicked out
isMember turned to false, all other account balances to zero, except _CCUs
##function getBudget
get Commune budget state
##function getParameters
get the currency parameters
##function getMoneyTotals
get the monetary Totals
##function newParameters 
the treasury account can change the currency parameters
_newDemurrage is the new demurrage rate. % x 100
_newrewardRate is the new reward rate for successful credits. % x 100
_newIniCCUs is the new initial Community Currency Units given to any new member
_newIniR is the new initial Reputation given to any new member
new demurrage, reward rate, initial CCUs and initial reputation for new members
##function newCommune
the treasury account can change to a new community address
_newCommunity is the new address holding the Community permissions
new community address
##function newTreasury 
the community account can change to a new treasury address
_newTreasury is the new address holding the Community permissions
new treasury address
##function setNewBudget 	
set new rolling Commune budget
##function setExchange
set new exchange
##function creditUpdate
update the credit status
check if deadline is over
if time is over reset credit to zero, deadline to zero
if balance is negative the credit was not returned, the money lender balanceReputation is not restored and is penalized with a 20%, as regards the borrower will not be able to make any new transfer until future incomes cover the debts, money lender reputation penalized
if balance is not negative the credit was returned, the money lender balanceReputation is restored and is rewardRateed with a 20%, money lender reputation rewarded
##function transfer
function make a payment
anybody with an ethereum account can make a payment if he has sufficient CCUs in the balance
any member can add to the amount available at the balance, what remains unused in the credit line
_payee is the account to be credited
_payment is the amount in CCUs to be send
balance of payee increased
balance of sender decreased
if necessary, available credit decreased	
credit information updated
pay with the CCUs available at the balance and the credit
_available is the spending limit of an account, given the account balance in _CCUs and the _credit
##function credit
function authorize a credit
only members can authorize or get a credit
_borrower is the address of the credit borrower
_credit is the amount of the credit line in CCUs
_daysAfter is the deadline of the credit line in number of days from today
##function monitorWallet	
monitor Wallet
the borrower candidate has given access to monitor all relevant parameters of his account to the money lender
the community can also monitor all accounts
_monitored is the address to be monitored
_getCCUs is the balance in CCUs 
_getCredit is the remaining credit
_getDeadline is the credit deadline
_getMoneyLender is the address of the current money lender or the candidate money lender
_getUnitsOfTrust is the cost in reputation of the credit
_getIsMember is boolean if the account is a member
_getAlias is the alias
_getReputation is the reputation in UoTs
_getLast is the date of the last transaction
##function accessMyWallet	
authorize monitoring
##function claimHours	
claim Hours to paid from Community
##function payHours
the Commune pays Hours
##function payFunding	
a Commoner pays CrowdFunding
##function payExpenses	
the Commune pays Expenses
