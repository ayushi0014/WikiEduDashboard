McFly       = require 'mcfly'
Flux        = new McFly()
API         = require '../utils/api'

ServerActions = Flux.createActions
  fetchCourse: (course_id) ->
    API.fetchCourse(course_id).then (data) ->
      { actionType: 'RECEIVE_COURSE', data: data }
  fetchCohorts: (course_id) ->
    API.fetchCohorts(course_id).then (data) ->
      { actionType: 'RECEIVE_COHORTS', data: data }
  fetchTimeline: (course_id) ->
    API.fetchTimeline(course_id).then (data) ->
      { actionType: 'RECEIVE_TIMELINE', data: data }
  fetchUsers: (course_id) ->
    API.fetchUsers(course_id).then (data) ->
      { actionType: 'RECEIVE_USERS', data: data }
  fetchRevisions: (course_id) ->
    API.fetchRevisions(course_id).then (data) ->
      { actionType: 'RECEIVE_REVISIONS', data: data }
  fetchArticles: (course_id) ->
    API.fetchArticles(course_id).then (data) ->
      { actionType: 'RECEIVE_ARTICLES', data: data }
  fetchAssignments: (course_id) ->
    API.fetchAssignments(course_id).then (data) ->
      { actionType: 'RECEIVE_ASSIGNMENTS', data: data }
  fetchUploads: (course_id) ->
    API.fetchUploads(course_id).then (data) ->
      { actionType: 'RECEIVE_UPLOADS', data: data }
  fetchWizardIndex: ->
    API.fetchWizardIndex().then (data) ->
      { actionType: 'RECEIVE_WIZARD_INDEX', data: {
        wizard_index: data
      }}
  fetchWizardPanels: (wizard_id) ->
    API.fetchWizardPanels(wizard_id).then (data) ->
      { actionType: 'RECEIVE_WIZARD_PANELS', data: {
        wizard_panels: data
      }}
  saveCourse: (data, course_id=null) ->
    API.saveCourse(data, course_id).then (data) ->
      actionType = if course_id == null then 'CREATED_COURSE' else 'SAVED_COURSE'
      { actionType: actionType, data: data }
  saveStudents: (data, course_id) ->
    API.saveStudents(data, course_id).then (data) ->
      { actionType: 'SAVED_USERS', data: data }
  saveTimeline: (data, course_id) ->
    API.saveTimeline(course_id, data).then (data) ->
      { actionType: 'SAVED_TIMELINE', data: data }
  saveGradeables: (data, course_id) ->
    API.saveGradeables(course_id, data).then (data) ->
      { actionType: 'SAVED_TIMELINE', data: data }
  submitWizard: (data, course_id, wizard_id) ->
    API.submitWizard(course_id, wizard_id, data).then (data) ->
      { actionType: 'WIZARD_SUBMITTED', data: data }

  checkCourse: (key, course_id) ->
    API.checkCourse(course_id).then (data) ->
      message = if data.course_exists then 'This course already exists' else null
      { actionType: 'CHECK_SERVER', data: {
        key: key
        message: message
      }}
  deleteCourse: (course_id) ->
    # This redirects, no need for an action to be broadcast
    API.deleteCourse(course_id)
  manualUpdate: (course_id) ->
    API.manualUpdate(course_id).then (data) ->
      { actionType: 'MANUAL_UPDATE', data: data }
  notifyUntrained: (course_id) ->
    API.notifyUntrained(course_id).then (data) ->
      { actionType: 'NOTIFIED_UNTRAINED', data: data }

  enrollStudent: (data, course_id) ->
    API.enrollStudent(data, course_id).then (data) ->
      { actionType: 'ENROLLED_STUDENT', data: data }
  unenrollStudent: (data, course_id) ->
    API.unenrollStudent(data, course_id).then (data) ->
      { actionType: 'ENROLLED_STUDENT', data: data }
  listCourse: (course_id, cohort_title) ->
    API.listCourse(course_id, cohort_title, true).then (data) ->
      { actionType: 'LIST_COURSE', data: data }
  delistCourse: (course_id, cohort_title) ->
    API.listCourse(course_id, cohort_title, false).then (data) ->
      { actionType: 'LIST_COURSE', data: data }

module.exports = ServerActions