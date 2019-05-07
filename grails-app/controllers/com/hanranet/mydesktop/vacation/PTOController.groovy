package com.hanranet.mydesktop.vacation

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured("hasRole('ROLE_ADMIN')")
class PTOController {

    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "get"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PTO.list(params), model:[PTOCount: PTO.count()]
    }

    def show(PTO PTO) {
        redirect controller: "Event", action:"index"
    }

    def create() {
        respond new PTO(params)
    }

    @Transactional
    def save(PTO PTO) {
        if (PTO == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (PTO.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond PTO.errors, view:'create'
            return
        }

        def user = springSecurityService.currentUser

        PTO.setEndDate(new Date())
        PTO.setOwner(user.name)
        PTO.setEndDate(PTO.startDate.plus(365))

        PTO.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'PTO.label', default: 'PTO'), PTO.id])
                redirect PTO
            }
            '*' { respond PTO, [status: CREATED] }
        }
    }

    def edit(PTO PTO) {
        respond PTO
    }

    @Transactional
    def update(PTO PTO) {
        if (PTO == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (PTO.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond PTO.errors, view:'edit'
            return
        }

        PTO.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PTO.label', default: 'PTO'), PTO.id])
                redirect PTO
            }
            '*'{ respond PTO, [status: OK] }
        }
    }

    @Transactional
    def delete(PTO PTO) {

        if (PTO == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        PTO.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PTO.label', default: 'PTO'), PTO.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'PTO.label', default: 'PTO'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
