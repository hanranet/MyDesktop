package com.hanranet.mydesktop.receipts

import com.hanranet.mydesktop.budget.Item

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ReceiptController
{

    static allowedMethods = [save: "POST", update: "POST", delete: "GET"]

    def balanceService

    def beforeInterceptor = [action:this.&auth]

    def auth()
    {
        println "This is a test of auth"
//        if (!session.user)
//        {
//            redirect(controller:"user", action:"login")
//            return false
//        }
    }

    def index()
    {
        def balance = balanceService.getLastStatementEndingBalace()

        def receiptList = Receipt.findAllByOwnerAndReconcileNoIsNull("thanrahan", [sort: ['date': 'asc', 'debit': 'desc']])

        receiptList.each { receipt->

            if (receipt.debit > 0)
            {
                balance = balance + receipt.debit
                receipt.balance = balance
                receipt.reconcileAmount = receipt.debit
            }

            if (receipt.credit > 0)
            {
                balance = balance - receipt.credit
                receipt.balance = balance
                receipt.reconcileAmount = receipt.credit * -1
            }
        }

        [receiptList: receiptList]

    }

    def show(Receipt receipt) {
        redirect action:"index"
    }

    def create() {

        def categoryList = Item.list()
        categoryList.add(new Item(name: "Salary"))

        [receipt: new Receipt(params), categoryList: categoryList]

    }

    @Transactional
    def save(Receipt receipt)
    {
        if (receipt == null)
        {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (receipt.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond receipt.errors, view:'create'
            return
        }

        receipt.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'receipt.label', default: 'Receipt'), receipt.id])
                redirect receipt
            }
            '*' { respond receipt, [status: CREATED] }
        }
    }

    def edit(Receipt receipt) {

        def categoryList = Item.list()
        categoryList.add(new Item(name: "Salary"))

        [receipt: Receipt.get(params.id), categoryList: categoryList]
    }

    @Transactional
    def update(Receipt receipt) {

        if (receipt == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (receipt.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond receipt.errors, view:'edit'
            return
        }

        receipt.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'receipt.label', default: 'Receipt'), receipt.id])
                redirect receipt
            }
            '*'{ respond receipt, [status: OK] }
        }
    }

    @Transactional
    def delete(Receipt receipt) {

        if (receipt == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        receipt.delete flush:true

        flash.message = message(code: 'default.deleted.message', args: [message(code: 'receipt.label', default: 'Receipt'), receipt.id])
        redirect action:"index"

    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'receipt.label', default: 'Receipt'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
