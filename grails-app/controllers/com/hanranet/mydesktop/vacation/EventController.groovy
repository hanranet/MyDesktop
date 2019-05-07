package com.hanranet.mydesktop.vacation

import grails.plugin.springsecurity.annotation.Secured

import java.time.LocalDate

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import com.hanranet.mydesktop.PTOService

import static java.time.temporal.TemporalAdjusters.firstDayOfYear

@Transactional(readOnly = true)
@Secured("hasRole('ROLE_ADMIN')")
class EventController {

    def springSecurityService
    def PTOService

    static allowedMethods = [save: "POST", update: "POST", delete: "GET"]

    def index() {

        def user = springSecurityService.currentUser

        LocalDate now = LocalDate.now()
        java.util.Date firstDay = java.sql.Date.valueOf(now.with(firstDayOfYear()))

        def ptoBalance = PTO.withCriteria {
            ge('endDate', firstDay)
            eq('owner', user.username)
            ge('days', '1')
        }

        calculateTotals(ptoBalance)

        def eventList = Event.findAllByOwner(user.username)

        [eventList: eventList, ptoBalanceList: ptoBalance ]

    }

    def show(Event event) {
        redirect action:"index"
    }

    def create() {

        def user = springSecurityService.currentUser

        LocalDate now = LocalDate.now()
        java.util.Date firstDay = java.sql.Date.valueOf(now.with(firstDayOfYear()))

        def typeList = PTO.withCriteria {
            ge('endDate', firstDay)
            eq('owner', user.username)
            ge('days', '1')
        }

        [event: new Event(params), typeList: typeList]

    }

    @Transactional
    def save(Event event) {

        def user = springSecurityService.currentUser

        event.owner = user.username
        event.endDate = event.startDate.plus(event.days)

        if (event == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (event.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond event.errors, view:'create'
            return
        }

        event.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'event.label', default: 'Event'), event.id])
                redirect event
            }
            '*' { respond event, [status: CREATED] }
        }
    }

    def edit(Event event) {

        def user = springSecurityService.currentUser

        LocalDate now = LocalDate.now()
        java.util.Date firstDay = java.sql.Date.valueOf(now.with(firstDayOfYear()))

        def typeList = PTO.withCriteria {
            ge('endDate', firstDay)
            eq('owner', user.username)
            ge('days', '1')
        }

        [event: event, typeList: typeList]

    }

    @Transactional
    def update(Event event) {

        def user = springSecurityService.currentUser

        event.owner = user.username
        event.endDate = event.startDate.plus(event.days)

        if (event == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (event.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond event.errors, view:'edit'
            return
        }

        event.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'event.label', default: 'Event'), event.id])
                redirect event
            }
            '*'{ respond event, [status: OK] }
        }
    }

    @Transactional
    def delete(Event event) {

        if (event == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        event.delete flush:true

        flash.message = message(code: 'default.deleted.message', args: [message(code: 'event.label', default: 'Event'), event.id])
        redirect controller: "event", action: "index"
    }

    private calculateTotals(ArrayList<PTO> ptoArrayList){

        ptoArrayList.each { PTO ->

            def used = PTOService.getHoursUsed(PTO)
            PTO.setUsed(used.toString())

            def days = new Integer(PTO.getDays())

            def left = days - used
            PTO.setLeft(left.toString())
        }

        ptoArrayList

    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
