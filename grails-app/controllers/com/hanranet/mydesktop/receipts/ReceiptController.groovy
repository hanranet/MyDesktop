package com.hanranet.mydesktop.receipts

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ReceiptController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Receipt.list(params), model:[receiptCount: Receipt.count()]
    }

    def show(Receipt receipt) {
        respond receipt
    }

    def create() {
        respond new Receipt(params)
    }

    @Transactional
    def save(Receipt receipt) {
        if (receipt == null) {
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
        respond receipt
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

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'receipt.label', default: 'Receipt'), receipt.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
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
