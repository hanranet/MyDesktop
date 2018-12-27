package com.hanranet.mydesktop.statements

import com.hanranet.mydesktop.receipts.Receipt

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class StatementController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Statement.list(params), model:[statementInstanceTotal: Statement.count()]
    }

    def show(Statement statement) {

        def statementInstance = Statement.get(params.id)
        if (!statementInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'statement.label', default: 'Statement'), params.id])
            redirect(action: "list")
            return
        }

        def receiptList = Receipt.findAllByOwnerAndReconcileNo("thanrahan", statementInstance.id)

        def debitReceipts = new ArrayList()
        def creditReceipts = new ArrayList()

        receiptList.each { receipt->

            if (receipt.debit > 0)
            {
                debitReceipts.add(receipt)
            }
            else
            {
                creditReceipts.add(receipt)
            }
        }

        [statementInstance: statementInstance, debitReceipts: debitReceipts, creditReceipts: creditReceipts]
    }

    def create() {

        def statement = new Statement()

        def lastStatement = Statement.find("FROM Statement ORDER BY dateCreated")

        if (lastStatement) {
            statement.beginDate = lastStatement.endingDate + 1
            statement.beginBalance = lastStatement.endingBalance
            statement.endingDate = lastStatement.endingDate + 30
        }

        def receiptList = Receipt.findAllByOwnerAndReconcileNoIsNull("thanrahan")

        def debitReceipts = new ArrayList()
        def creditReceipts = new ArrayList()

        receiptList.each { receipt->

            if (receipt.debit > 0)
            {
                debitReceipts.add(receipt)
            }

            if (receipt.credit > 0)
            {
                creditReceipts.add(receipt)
            }
        }

        [statementInstance: statement, debitReceipts: debitReceipts, creditReceipts: creditReceipts]
    }

    @Transactional
    def save(Statement statement) {

        statement.owner = 'thanrahan'

        if (statement == null)
        {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (statement.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond statement.errors, view:'create'
            return
        }

        statement.save flush:true

        println params

        def creditList = params.creditReceipts

        creditList.each{receiptId->

            def receipt = Receipt.get(receiptId)

            receipt.reconcileNo = statement.id
            receipt.updateUser = "SYSTEM_RECONCILE"
            receipt.lastUpdated = new Date()

            if (!receipt.save(flush: true)) {
                println("Unable to update credit receipt during reconciliation - id=" + receipt.id + " statementid=" + statementInstance.id)
            }

        }

        def debitList = params.debitReceipts

        debitList.each{receiptId->

            def receipt = Receipt.get(receiptId)

            receipt.reconcileNo = statement.id
            receipt.updateUser = "SYSTEM_RECONCILE"
            receipt.lastUpdated = new Date()

            if (!receipt.save(flush: true)) {
                println("Unable to update debit receipt during reconciliation - id=" + receipt.id + " statementid=" + statementInstance.id)
            }

        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'statement.label', default: 'Statement'), statement.id])
                redirect statement
            }
            '*' { respond statement, [status: CREATED] }
        }

    }

    def edit(Statement statement) {

        respond statement
    }

    @Transactional
    def update(Statement statement) {
        if (statement == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (statement.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond statement.errors, view:'edit'
            return
        }

        statement.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'statement.label', default: 'Statement'), statement.id])
                redirect statement
            }
            '*'{ respond statement, [status: OK] }
        }
    }

    @Transactional
    def delete(Statement statement) {

        if (statement == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        statement.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'statement.label', default: 'Statement'), statement.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'statement.label', default: 'Statement'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
