package com.hanranet.mydesktop.vacation

import grails.test.mixin.*
import spock.lang.*

@TestFor(PTOController)
@Mock(PTO)
class PTOControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null

        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
        assert false, "TODO: Provide a populateValidParams() implementation for this generated test suite"
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.vacationBalanceList
            model.vacationBalanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.vacationBalance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def vacationBalance = new PTO()
            vacationBalance.validate()
            controller.save(vacationBalance)

        then:"The create view is rendered again with the correct model"
            model.vacationBalance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            vacationBalance = new PTO(params)

            controller.save(vacationBalance)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/vacationBalance/show/1'
            controller.flash.message != null
            PTO.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def vacationBalance = new PTO(params)
            controller.show(vacationBalance)

        then:"A model is populated containing the domain instance"
            model.vacationBalance == vacationBalance
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def vacationBalance = new PTO(params)
            controller.edit(vacationBalance)

        then:"A model is populated containing the domain instance"
            model.vacationBalance == vacationBalance
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/vacationBalance/index'
            flash.message != null

        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def vacationBalance = new PTO()
            vacationBalance.validate()
            controller.update(vacationBalance)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.vacationBalance == vacationBalance

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            vacationBalance = new PTO(params).save(flush: true)
            controller.update(vacationBalance)

        then:"A redirect is issued to the show action"
            vacationBalance != null
            response.redirectedUrl == "/vacationBalance/show/$vacationBalance.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/vacationBalance/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def vacationBalance = new PTO(params).save(flush: true)

        then:"It exists"
            PTO.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(vacationBalance)

        then:"The instance is deleted"
            PTO.count() == 0
            response.redirectedUrl == '/vacationBalance/index'
            flash.message != null
    }
}
