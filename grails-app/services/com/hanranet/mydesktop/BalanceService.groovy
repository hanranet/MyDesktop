package com.hanranet.mydesktop

import com.hanranet.mydesktop.receipts.Receipt
import com.hanranet.mydesktop.statements.Statement
import grails.transaction.Transactional

@Transactional
class BalanceService {

    def getReceiptBalance(String owner) {

        BigDecimal debits = new BigDecimal(0)

        def rs = Receipt.executeQuery("select sum(debit) from Receipt where owner = '" + owner + "' and reconcile_no is null")

        if (!rs.isEmpty()) {
            debits = new BigDecimal(rs[0])
        }

        BigDecimal credits = new BigDecimal(0)
        def rs2 = Receipt.executeQuery("select sum(credit) from Receipt where owner = '" + owner + "' and reconcile_no is null")
        if (!rs2.isEmpty()) {
            credits = new BigDecimal(rs2[0])
        }

        BigDecimal balance = getLastStatementEndingBalace(owner)
        balance = balance.add(debits)
        balance = balance.subtract(credits)

        balance
    }

    def BigDecimal getLastStatementEndingBalace(String owner) {

        def balance = new BigDecimal(0.0)

        def lastStatement = Statement.find("FROM Statement where owner = '" + owner + "' ORDER BY dateCreated")

        if (lastStatement) {
            balance = lastStatement.endingBalance
        }

        return balance
    }

}
