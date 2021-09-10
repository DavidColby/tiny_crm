import { Application, definitionsFromContext } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.warnings = true
application.debug    = false
window.Stimulus      = application

const context = require.context("./", true, /_controller\.js$/)
application.load(definitionsFromContext(context))
