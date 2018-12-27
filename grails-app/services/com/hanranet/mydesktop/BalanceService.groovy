package com.hanranet.mydesktop

import com.hanranet.mydesktop.receipts.Receipt
import com.hanranet.mydesktop.statements.Statement
import grails.transaction.Transactional

@Transactional
class BalanceService {

    def getBalance() {
        // pull from ending balance on last statement
        BigDecimal startingBalance = new BigDecimal(0)
        BigDecimal debits = new BigDecimal(0)
        def rs = Receipt.executeQuery("select sum(debit) from Receipt")
        if (!rs.empty()) {
            debits = new BigDecimal(rs)
        }

        BigDecimal credits = new BigDecimal(0)
//        def rs2 = Receipt.executeQuery("select sum(credit) as credits from Receipt")
//        if (rs2.credits) {
//            credits = new BigDecimal(rs.credits)
//        }
        println "Debits= $debits"
        println "Credits= $credits"

        BigDecimal balance = new BigDecimal(0)
        balance = balance.add(debits)
        balance = balance.subtract(credits)

        balance
    }

    def BigDecimal getLastStatementEndingBalace() {

        def balance = new BigDecimal(0.0)

        def lastStatement = Statement.find("FROM Statement ORDER BY dateCreated")

        if (lastStatement) {
            balance = lastStatement.endingBalance
        }

        return balance
    }

}
