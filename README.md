#Community-Currency
A community currency **template** with zero reserve mutual credit and adjustable parameters  

#Purpose  
This is not intended to be a global currency. It is intended to become an ecosystem of community currencies using this template, each of them with different parameters according to the needs of each community.  
The type of community we mean is local communities (for example a municipality) or communities with charitable, service, participatory or empowering orientation, that run mixed economies with **free market** combined with community **public budget** and public redistributive works. Examples can be local authorities, social movements associations, social economy businesses, workers unions, etc. It includes therefore an (optional) *taxation* function. Each community is supposed to name their currency with a different name. 

#Currency Governance and monetary decission process
We decouple the contract running the decission process in a supposed DAO and the currency contract running the monetary mechanics.
The DAO may use whatever more or less traditional or more or less innovative democracy to take decissions.   
The community is supposed to be managed by a DAO at ethereum or outside ethereum, or just run by a DAO using handwritten notebooks or any eGovernance software. The currency contract does not cover how the DAO is managed, the votings and decision mechanisms.   
Once the DAO has taken the main monetary decissions it passes the wished parameters to the currency contract through the two accounts allowed to change the settings of the currency: the **treasury** account and the **community** account.
At creating the currency contract you may set who they are.  
The currency desing presumes that all monetary decissions of the community are implemented through two trusted accounts:
* the **treasury** account. Creates the currency, sets the basic parameters and deploys it to the blockchain. It can mint and assign amounts of **CCUs** (Community Currency Units).
* the **community** account. Admits or kickouts members. It can mint and assign amounts of **Reputation**. 
**Users** making a transfer can be anybody having an ethereum account. 
**Members**, additionally, can authorize credits to other members. Anybody, including Members, may have different ethereum accounts. The community is supposed to have external mechanisms to establish the **identity** of a person, and therefore establish which of his accounts this person prefers to use as the unique account as member. 

#Background   
- [What the hell is p2p credit](http://desperado-theory.blogspot.be/2015/05/what-hell-is-p2p-credit.html) at DESPERADOS THEORY blog  
- [Moneda con pagos y creditos p2p sin reserva](http://desperado-theory.blogspot.com.es/2015/08/moneda-con-pagos-y-creditos-p2p-sin.html) at DESPERADOS THEORY blog  
- [Apuntes sobre la soberania monetaria](http://www.monedasocial.org/apuntes-soberania-monetaria/) at Instituto de la Moneda Social  
- The design has been strongly inspired on the paper [Notas para una propuesta de dinero-crédito descentralizado y basado en la reputación](http://socialcurrency.sciencesconf.org/conference/socialcurrency/pages/Capital_confianzafinal.pdf) presented at the [III Conferencia Internacional de Monedas Complementarias, 28 de octubre de 2015 Salvador de Bahía](http://socialcurrency.sciencesconf.org/). The paper reflects the experience of the complementary currency [EUROCAT](http://euro-cat.cat/es/) in Catalunya. 
- It builds as well on the analysis made by the EU/FP7 project [D-CENT: Freecoin Toolchain Design and application to Pilots](www.dcentproject.eu) about the funcional requirements of the EUROCAT currency: [Design of Social Digital Currency](http://dcentproject.eu/wp-content/uploads/2015/10/design_of_social_digital_currency_publication.pdf)  

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
- *demurrage*; a periodic depretiation on the monetary assets. Not used. Judget as unwanted   
- **rewardRate**; reward Rate to the moneyLender of a successful credit, as a multiplier of the Reputation Cost of the credit. % x 100  
- **iniMemberCCUs**; intitial Community Currency Units given to any new member. The monetary mass is automatically increased with any new member. By default, the total monetary mass is proportional to the number of members
- **iniMemberReputation**; initial Reputation given to any new member

#Indicators
Each account has an **activity indicator** showing the average GDP it is moving. It is using the basic monetarist formula of M x C average over time. In practice gdpActivity = AVERAGE (payment/timeDelta)  
The to-be money lender can access this indicator  
The community can access this indicator  
However, the indicator is not used mechanically to take any decission through an algotiyhm, for example authorize a credit. We assume always a human intermediation to interpretate the results. 

#Functions
##acceptMember
the community account can accept accounts as members  
a community can opt to name the community account as member or not and therefore give credits or not from that account
##kickOutMember
the community acount can kick out members
##newParameters  
the treasury account can change the currency parameters
##mintAssignCCUs
the treasury account can issue as much communityCurrency it likes and send it to any Member  
warning: it increases the monetary mass 
##mintAssignReputation
the community account can issue as much Reputation it likes and send it to any Member 
##transfer
make a payment: anybody can make a payment if he has sufficient CCUs and / or credit  
every payment will update the credit status
##credit
only members can authorize or get a credit

##monitorWallet
if you are authorized it gives you the account data. The community account has access to all accounts
- _communityCUnits	
- _credit
- _deadline
- _moneyLender
- _reputation
- _unitsOfTrust
- _isMember
- _last
- _gdpActivity

##accessMyWallet  
authorize monitoring to a particular account. Normally, the authorization to monitor own accounts is given to a candidate money lender. During a credit, only the money lender and the community have access. 
